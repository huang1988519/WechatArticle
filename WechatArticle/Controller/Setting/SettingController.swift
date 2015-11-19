//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


import UIKit
import AVOSCloud
import CoreLocation
import JLToast


class SettingController: UITableViewController, CLLocationManagerDelegate{

    @IBOutlet weak var userCell: UITableViewCell!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pmLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    let locationManager :CLLocationManager = CLLocationManager()
    let ak = "3cSn0P7TOrl9veCRBDXwq7UF" //百度地图 ak
    let session = NSURLSession.sharedSession() //请求天气
    
    var timer :NSTimer!
    var isLogin = false {
        didSet {
            refreshUserInfo()
        }
    }
    
    class func Nib() -> SettingController {
        let sb = MainSB()
        return (sb.instantiateViewControllerWithIdentifier("SettingController") as? SettingController)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter  = kCLLocationAccuracyKilometer
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //ios 8 request
        locationManager.requestWhenInUseAuthorization()
        refreshWeather()
        
        //如果debug环境设置为 60s 刷新一次
        let time = 60.00*60.00
        #if DEDUG
            time = 60.00
        #endif
        //定时器
        timer = NSTimer(timeInterval: time, target: self, selector: Selector("refreshWeather"), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshUserInfo()
    }
    /**
     退出登录
     
     - parameter sender: 按钮
     */
    @IBAction func logout(sender: AnyObject) {
        AVUser.logOut()
        isLogin = false
    }
    func refreshUserInfo() {
        let currentUser = AVUser.currentUser()
        if let user = currentUser {
        isLogin = true
        
        userCell.textLabel?.text = "用户 \(user.username) 您好"
        }else{
        isLogin = false
        }
    }
    /**
     刷新 坐标
     */
    func refreshWeather() {
        log.debug("重新定位")
        locationManager.startUpdatingLocation()
    }
    /**
     请求天气信息
     
     - parameter location: 需要请求天气的坐标
     */
    func requestWeather(location:CLLocation) {
        let coordinate = location.coordinate
        
        let locationString = "location=\(coordinate.latitude),\(coordinate.longitude)"
        let urlString = "http://api.map.baidu.com/telematics/v3/weather?\(locationString)&output=json&ak=\(ak)"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("", forHTTPHeaderField: "")
        let task = session.dataTaskWithRequest(request) { [unowned self](data, response, error) -> Void in
            if let res = response as? NSHTTPURLResponse {
                if res.statusCode != 200 {
                    log.error("请求天气error")
                    return
                }
            }
            if data == nil{
                log.error("返回的天气信息为空")
                return
            }
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: [.AllowFragments]) as? [String:AnyObject]
                if object == nil {
                    log.error("json 解析出错")
                }
                
                if let returnError = object!["error"] as? Int {
                    if returnError != 0 {
                        log.error("百度地图返回错误码\(object)")
                        return
                    }
                }
                if let dic = object!["results"] as? [String:AnyObject] {
                    self.parserWeather(dic)
                }else{
                    log.error("百度地图返回格式错误")
                }
            }catch {
                log.error("json 解析异常")
            }
            
        }
        task.resume()
    }
    func parserWeather(dic :[String:AnyObject]) {
        log.debug("天气信息为:\(dic)")
        let currentCity = dic["currentCity"] as? String
        let pm25 = dic["pm25"] as? String
        let weatherList = dic["weather_data"] as? [[String:AnyObject]]
        
        var weather :[String:AnyObject]?
        if weatherList?.count > 0 {
            weather = weatherList?.first
        }
        
        cityLabel.text = currentCity
        pmLabel.text   = "\(pm25) PM25"
        if let tianqi = weather!["weather"] as? String {
            weatherLabel.text = tianqi
        }
    }
    //MARK: --
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.isEmpty {
            log.error("没有定位信息！")
            return
        }
        let location = locations.first
        requestWeather(location!)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.Denied.rawValue {
            JLToast.makeText("定位被拒绝").show()
        }else{
            JLToast.makeText("定位失败").show()
        }
        locationManager.stopUpdatingLocation()

    }
    //MARK: --
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if GetUserInfo() != nil && (isLogin == true) {
                
            }else{
                let nav = MainSB().instantiateViewControllerWithIdentifier("LoginControllerNav")
                App().window?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
            }
        }
    }
}
