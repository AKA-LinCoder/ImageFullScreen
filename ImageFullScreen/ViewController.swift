//
//  ViewController.swift
//  ImageFullScreen
//
//  Created by lsaac on 2022/4/18.
//

import UIKit

 
extension UINavigationController{
    
    /// 导航栏设置
        /// - Parameters:
        ///   - titleColor: 标题颜色
        ///   - tintColor: 按钮颜色
        ///   - barTintColor: 背景色
        ///   - lineIshidden: 隐藏横线
        ///   - isLucency: 导航栏透明
        func customNavigationBar( titleColor: UIColor =
                                  UIColor.init(red: 51, green: 51, blue: 51, alpha: 1), tintColor: UIColor = UIColor.init(red: 51, green: 51, blue: 51, alpha: 1), barTintColor: UIColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1), lineIshidden: Bool = false, isLucency: Bool = false){
            
            //兼容iOS15设置导航栏
            if #available(iOS 13.0, *) {
                let barApp = UINavigationBarAppearance()
    //            barApp.configureWithTransparentBackground() //配置具有透明背景且无阴影的条形外观对象。
    //            barApp.configureWithDefaultBackground() //使用默认背景和阴影值配置条形外观对象。
    //            barApp.configureWithOpaqueBackground() //使用一组适合当前主题的不透明颜色配置栏外观对象。
                barApp.backgroundColor = isLucency ? UIColor.clear : UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
                //基于backgroundColor或backgroundImage的磨砂效果
                barApp.backgroundEffect = nil
                //阴影颜色
                barApp.shadowColor = lineIshidden ? UIColor.clear : UIColor.init(red:248, green:248, blue:253, alpha:1)
                //标题文本的字符串属性
                barApp.titleTextAttributes = [.foregroundColor: titleColor]
                navigationController?.navigationBar.scrollEdgeAppearance = barApp
                navigationController?.navigationBar.standardAppearance = barApp
            }else{
                //设置标题
                navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
                //隐藏导航栏横线
                navigationController?.navigationBar.shadowImage = lineIshidden ? UIImage() : nil
                //导航栏透明
                navigationController?.navigationBar.setBackgroundImage(isLucency ? UIImage() : nil, for: .default)
            }
            self.navigationController?.navigationBar.tintColor = tintColor
    //        self.navigationController?.navigationBar.barTintColor = barTintColor
        }
}



class ViewController: UIViewController {

     

    let images = ["people.png","player.png","1.jpg"]

 

    override func viewDidLoad() {
            
        super.viewDidLoad()
        view.backgroundColor = .white
    
//        self.navigationController = SelfNavBar()
        self.navigationItem.title = "haha"

        //修改导航栏返回按钮文字

        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)

        self.navigationItem.backBarButtonItem = item;

         

        //生成缩略图

        for i in 0..<images.count{

            //创建ImageView

            let imageView = UIImageView()

            imageView.frame = CGRect(x:20+i*70, y:80, width:60, height:60)

            imageView.tag = i

            imageView.contentMode = .scaleAspectFill

            imageView.clipsToBounds = true

            imageView.image = UIImage(named: images[i])

            //设置允许交互（后面要添加点击）

            imageView.isUserInteractionEnabled = true

            self.view.addSubview(imageView)

            //添加单击监听

            let tapSingle=UITapGestureRecognizer(target:self,

                                                 action:#selector(imageViewTap(_:)))

            tapSingle.numberOfTapsRequired = 1

            tapSingle.numberOfTouchesRequired = 1

            imageView.addGestureRecognizer(tapSingle)

        }

    }

     

    //缩略图imageView点击

    @objc func imageViewTap(_ recognizer:UITapGestureRecognizer){
        print("tapo")
        //图片索引

        let index = recognizer.view!.tag

        //进入图片全屏展示

        let previewVC = ImagePreviewVC(images: images, index: index)

        self.navigationController?.pushViewController(previewVC, animated: true)

    }

 

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }
    
 
   

}
