import Foundation


extension URLSession {
    func post(url: URL, headers: [String: String], data: [String: Any], timeout: Int) {
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        request.timeoutInterval = TimeInterval(timeout)
        let task = dataTask(with: request) { data_, resp_, error_ in
            if let resp = resp_ {
                print(resp)
            }
            
            if let data = data_ {
                do {
                    let obj = try JSONSerialization.jsonObject(with: data)
                    print(obj)
                } catch (let error) {
                    print("error decoding", error)
                    print(String(data: data, encoding: .utf8) as Any)
                }
            } else {
                print("no data")
            }
        }
        task.resume()
    }
}


class ViewModel {
    
    func getReceiptList(){
  
 
        // print(cookie)
        let last = "sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%221818970a83e4af-0a0eedf7c7e18c8-61096a4c-250125-1818970a841126%22%2C%22%24device_id%22%3A%221818970a83e4af-0a0eedf7c7e18c8-61096a4c-250125-1818970a841126%22%2C%22props%22%3A%7B%22%24latest_referrer%22%3A%22%22%2C%22%24latest_referrer_host%22%3A%22%22%2C%22%24latest_traffic_source_type%22%3A%22%E7%9B%B4%E6%8E%A5%E6%B5%81%E9%87%8F%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC_%E7%9B%B4%E6%8E%A5%E6%89%93%E5%BC%80%22%7D%7D"
        let cookie = """
        app_id=759A39EE0F1192ED686034AA4BB677F2; app_origin=iphone; app_version=238.3.5; sajssdk_2015_cross_new_user=1; \(last)
        """
        
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Connection" : "keep-alive",
            "X-XCF-SIGN" : "20a42a35c2ea355c7125a04535c4bfc5",
            "X-Proto-Version" : "1.12.0",
            "Accept" : "*/*",
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iOS 15.5 like Mac OS X) xiachufang-iphone/238.3.5 Build/395",
            "Cookie": cookie
        ]
        
        let data: [String: Any] = [
            "x_user_agent": "Mozilla\\/5.0 (iPhone; CPU iOS 15.5 like Mac OS X) xiachufang-iphone\\/238.3.5 Build\\/395",
            "version": "238.3.5",
            "api_key": "07397197043fafe11ce5c65c10febf84",
            "sk": "",
            "x_xcf_pdid": "759A39EE0F1192ED686034AA4BB677F2",
            "location_code": "",
            "nonce": "C63EFD6A-4D55-40F0-B477-CF30376D55F5",
            "size": 20,
            "_ts": "1655868629.772785",
            "webp": true,
            "origin": "iphone",
            "cursor": "",
            "x_xcf_network": 2,
            "x_xcf_psid": "BD3390AF-1DA8-444B-BB0D-0C5D3E6C0838"
        ]
        // print(Date().timeIntervalSince1970 * 1000)
        let url = "https://api.xiachufang.com/v2/homepage/paged_waterfall_recommendations.json"
        URLSession.shared.post(url: URL(string: url)!, headers: headers, data: data, timeout: 5)
    
        
    }
    
    func getShopList() {
        let curTime = Int64(Date().timeIntervalSince1970 * 1000)
        var time: Int64 = 1655867900443
        print(time - curTime)
        time = curTime
        let urlString = "https://i.waimai.meituan.com/openh5/channel/kingkongshoplist?_=\(time)"
        
        let cookie = """
        _lxsdk_cuid=1817f579ca4c8-03305138bb2cd1-367a6700-1d73c0-1817f579ca4c8; wm_order_channel=default; request_source=openh5; au_trace_key_net=default; isIframe=false; terminal=i; w_utmz="utm_campaign=(direct)&utm_source=5000&utm_medium=(none)&utm_content=(none)&utm_term=(none)"; bussiness_entry_channel=default; latlng=22.542274,113.913592; ci=30; cityname=深圳; lat=22.542274; lng=113.913592; IJSESSIONID=node09ia0niksj5ogkee2x9c7ek8541630267; iuuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; _lxsdk=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; _hc.v=2056ca18-b939-6501-164d-ff3720592e06.1655699025; ci3=30; uuid=3362f0d73ca646f48e4f.1655699032.1.0.0; openh5_uuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; openh5_uuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; WEBDFPID=z52433xv6y3w527v1w988967v23xx9uu81814746vx897958u2z1xzz1-1655882619562-; w_visitid=0529cb6e-2c26-4790-9216-a8268ab0641a; _lx_utm=utm_source=; cssVersion=f16939bc; _lxsdk_s=1818927620d-215-e8a-500||481
        """
        
        let mtgsig = """
        {"a1":"1.0","a2":\(time),"a3":"z52433xv6y3w527v1w988967v23xx9uu81814746vx897958u2z1xzz1","a4":"c012653dd411bf9b3d6512c09bbf11d426677949bdd8689d","a5":"AWPHgZ7Z3izog5L2FSNw0P2aR12Hhkz2AUHGPUIbHD2/zDaO9cBOWC7iMd4HhaZsuXvnZb3t7yyxdEeMlZ==","a6":"h1.0Cd5XNrqyZnFZbq3vKROXxDX4Pz9wlyEr8xwUPQzynD4Uug92lQOKkI1+4lv/YqVG8xPDnS+OaM52lqQS+7RbqFQ6ROwIoDPwRxJ61Fej6WGY6cim9lcikVNAMtdp0/QyfhaYIP74kzqowpFIUFmIhFJFN2veW3r8Eww8wHAzjdnzW0mk09/U4Y+nSF774irXx5RTd9cvLhccXtg0OgsWrGGfspBBMe29ofZdsKZMtnOB+yLpAv64kjAJnDgHf89f//WFfDAoYE/zoMXjOz5rq8xKhwKpCc8rmnZYrkMV98flskO+kiRBQSdRlzCQdXI/tqrELtf+zJJKYQePgKLslVNpKAjWYwah6ADA+HUsWfoOUy5EysPWs2c/A8/dJ2pjzEPripbtrFGCRxhw4ww+M4SIhXpu2VysKVa/kQMqB4dw3ZeV6XCbtuC7SprhgibcVvHPio7sLsku7KPOolluxA==","a7":"","x0":4,"d1":"0217ed1e67cc2b50ac10ec59ec7fd8c0"}
        """
        
        let sec_ch_ua = """
        " Not A;Brand";v="99", "Chromium";v="102", "Google Chrome";v="102"
        """
        
        let headers: [String: String] = [
            "Accept":"*/*",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
            "Connection": "keep-alive",
            "Content-Length": "1719",
            "Content-Type": "application/x-www-form-urlencoded",
            "Cookie": cookie,
            "Host": "i.waimai.meituan.com",
            "mtgsig": mtgsig,
            "Origin": "https://h5.waimai.meituan.com",
            "Referer": "https://h5.waimai.meituan.com/",
            "sec-ch-ua": sec_ch_ua,
            "sec-ch-ua-mobile": "?1",
            "sec-ch-ua-platform": "Android",
            "Sec-Fetch-Dest": "empty",
            "Sec-Fetch-Mode": "cors",
            "Sec-Fetch-Site": "same-site",
            "User-Agent": "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Mobile Safari/537.36",
        ]
        
        let url = URL(string: urlString)!
        let data: [String: Any] = [
            "sortId":"",
            "navigateType": "910",
            "firstCategoryId": "910",
            "secondCategoryId": "910",
            "multiFilterIds":"",
            "sliderSelectCode":"",
            "sliderSelectMin":"",
            "sliderSelectMax":"",
            "actualLat": "22.539227",
            "actualLng": "113.918452",
            "initialLat": "22.539227",
            "initialLng": "113.918452",
            "geoType": "2",
            "rankTraceId":"",
            "uuid": "F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB",
            "platform": "3",
            "partner": "4",
            "originUrl": "https://h5.waimai.meituan.com/waimai/mindex/kingkong?navigateType=910&firstCategoryId=910&secondCategoryId=910&title=%E7%BE%8E%E9%A3%9F&index=1",
            "riskLevel": "71",
            "optimusCode": "10",
            "wm_latitude": "22539227",
            "wm_longitude": "113918452",
            "wm_actual_latitude": "22539227",
            "wm_actual_longitude": "113918452",
            "wmUuidDeregistration": "0",
            "wmUserIdDeregistration": "0",
            "openh5_uuid": "F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB",
            "_token": "eJxdkNuOokAQht+FxLnByEERMJlsAFFhxAMgoJu9QGighebYCLrZd19mdjaT3aSSv+qrv9LV9ZOotZBYMDTD08yYuIOaWBDMhJ7MiTGBm6Ez5zhhzos0zfL0mAj+ZbPZMHStnSWx+D6j6bHIzH68A3Oov8BXNqWHeHdog4FIMC6bBUUl3KTzIfLhBAGIWz+fBAWi/iAKwTwEPZXCPE6LPP6W+3cY+xjYjxK8igz9EsG6wcpA4qJ+aOEHa0BQ5OF/EEOcgdeRyo9kdSSoI1UcSdORuHr5eOGVGX5MDLshe9ht0PRT/U/Ff2tjONHgbWCcDxnQHzhNs5pbSsckErfdsvazujvAt3WIKzXZWyduJ7y1rdayurV3GurJnyxSLveHm7cj7TuuQQ7K4gT2Sw1mKlJcR5Vc3s+rY66ESR80tEp2Tu3veNOWziSf15fAue0KmaPKXlaKs6+4AueR+oHeWkaisHt5c/X2AqJBc5ADgUxV0TMKibpEGeoylmVm1jYUlkmpMJssvG52Kf8oEH9DyxNlRUr7Vq6zmeftTHzrTMG/Gi6zTi/OnHGvFT6c+87FD3F+WgNWPm8YRWQzCUA2YvUiNdw7bIOVdrYLXbwmHHspiuZk+wlPanBfaeBGB4fI49n2GjjyZWpSWr+1lKVewEpu41rTEazPurpxmtxYPULUbNeoM5D3rPY3h1VT9FRKMdr6lUSLyQpPeynk4kxyoi2pr3ljuNQxDnMrIgv7Ud36RsYmMErzEKauGIfsDF3uYi6SlA2fTQiOjSvnZrryN+amFXYeK6+mGQkxFVyFbdRJXdI/Q2367Cl4vpdHzz5k0/B0f2OpOxWvVig6WsSv36fxCVg="
        ]
        URLSession.shared.post(url: url, headers: headers, data: data, timeout: 5)
    }
    
    func get_shop_info(session: URLSession = URLSession.shared,
                       wm_latitude: Int64 = 22634767,
                       wm_longitude: Int64=113834247) {
        let _ = """
        :param wm_longitude: 定位的经度
        :param wm_latitude: 定位的纬度
        :param session: 保持会话的实例
        :return: 商铺列表
        """
        
        //  header_cookie = ";".join([x + '=' + str(y) for x, y in cookie.items()])  # 请求头的Cookies拼接
        
        let cookie =
"""
_lxsdk_cuid=1817f579ca4c8-03305138bb2cd1-367a6700-1d73c0-1817f579ca4c8; wm_order_channel=default; request_source=openh5; au_trace_key_net=default; isIframe=false; terminal=i; w_utmz="utm_campaign=(direct)&utm_source=5000&utm_medium=(none)&utm_content=(none)&utm_term=(none)"; bussiness_entry_channel=default; latlng=22.542274,113.913592; ci=30; cityname=深圳; lat=22.542274; lng=113.913592; IJSESSIONID=node09ia0niksj5ogkee2x9c7ek8541630267; iuuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; _lxsdk=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; _hc.v=2056ca18-b939-6501-164d-ff3720592e06.1655699025; ci3=30; uuid=3362f0d73ca646f48e4f.1655699032.1.0.0; openh5_uuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; openh5_uuid=F9A124A103F7296B7D6367BE0B1E1346D273EE1BB128F1320A86F274869F54DB; _lx_utm=utm_source=; WEBDFPID=z52433xv6y3w527v1w988967v23xx9uu81814746vx897958u2z1xzz1-1655882619562-; w_visitid=c0c2b075-c9e9-4b5b-921c-c4820b1b6d66; channelType={"default":"0"}; channelConfig={"channel":"default","type":0,"fixedReservation":{"reservationTimeStatus":0,"startReservationTime":0,"endReservationTime":0}}; cssVersion=f16939bc; _lxsdk_s=18185d98316-93c-379-e3c||25
"""
        
        // print(cookie)
        
        let headers: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Origin": "https://h5.waimai.meituan.com",
            "Referer": "https://h5.waimai.meituan.com/waimai/mindex/home",
            "User-Agent": "Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Mobile Safari/537.36",
            "Cookie": cookie
        ]
        let start_index = 0
        let data: [String: Any] = [
            "startIndex": start_index,  // 页数；从0开始
            "sortId": 5,  // 排序方式；0是综合排序，5是距离最近
            "multiFilterIds": "",
            "sliderSelectCode": "",
            "sliderSelectMin": "",
            "sliderSelectMax": "",
            "geoType": 2,
            "wm_latitude": wm_latitude, // # 定位坐标
            "wm_longitude": wm_longitude,
            "wm_actual_latitude": 22634767, // # 真实坐标
            "wm_actual_longitude": 113834247,
            "_token": "",
        ]
        // print(Date().timeIntervalSince1970 * 1000)
        let time = Int64(Date().timeIntervalSince1970 * 1000)
        let url = "https://i.waimai.meituan.com/openh5/homepage/poilist?_=\(time)" //#.format(execjs.eval("Date.now()"))
        print("当前爬取坐标({data['wm_longitude']},{data['wm_latitude']})")
        session.post(url: URL(string: url)!, headers: headers, data: data, timeout: 5)
    }
}
