//
//  IntroViewController.swift
//  Dreams
//
//  Created by 장성구 on 2020/07/13.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class IntroViewController: UIViewController {
    
    var box = UIImageView()
   
    var newUserCheck = true
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var agoBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    //  컨텐츠 뷰컨트롤러들이 사용할 배경색 어레이입니다
    private let backgroundColors: [UIColor] = [.white, .white, .white, .white, .white]


    var images: [String] = ["intro1.jpg","intro2.jpg","intro3.jpg","intro4.jpg","intro5.jpg"]
    
    //  컨텐츠 뷰컨들이 올라갈 페이지 뷰컨이에요
    //  transitionStyle은 화면 전환 애니메이션
    //  navigationOrientation은 상하, 좌우 어디로 넘길건지
    private let pageViewController = UIPageViewController(transitionStyle: .pageCurl,
                                                          navigationOrientation: .horizontal)
    
    //  인디케이터로 사용할 페이지 컨트롤입니다
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .black   // 현재 페이지 인디케이터 색
        pc.pageIndicatorTintColor = .gray        // 나머지 페이지 인디케이터 색
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newUserCheck == false {
            print("체킹완료")
            DispatchQueue.main.async {
                self.agoBtn.isHidden = true
                self.nextBtn.isHidden = true
              self.performSegue(withIdentifier: "introNext", sender: nil)
              }
            
         
        } else {
            setPageViewController()
            setPageControl()
        }
        
      
        
        
    }
    
    func nextPage() {
         self.performSegue(withIdentifier: "introNext", sender: nil)
    }
    
    private func setPageViewController() {
        //  데이터소스와 델리게이트로 부모 뷰컨을 설정해줍니다
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        //  처음에 보여줄 컨텐츠 설정
        let firstVC = instantiateViewController(index: 0, color: backgroundColors[0])
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        //  페이지 뷰컨을 부모 뷰컨에 띄워줍니다
        

        
        view.addSubview(pageViewController.view)
       
        didMove(toParent: self)
    }
    
    
    
    @IBAction func agoBtn(_ sender: Any) {
        pageControl.currentPage = pageControl.currentPage - 1
              imageView.image = UIImage(named: images[pageControl.currentPage])
              
    }
  
    
    
    @IBAction func nextBtn(_ sender: Any) {
        if pageControl.currentPage >= 4 {
                   self.performSegue(withIdentifier: "introNext", sender: nil)
               }
               
               pageControl.currentPage = pageControl.currentPage + 1
               imageView.image = UIImage(named: images[pageControl.currentPage])
               
    }
    
        
       
        
        
        
  
    
    
    
    private func setPageControl() {
        //  페이지 컨트롤에 전체 페이지 수를 설정해줍시다
        pageControl.numberOfPages = backgroundColors.count
        
        

          
         
        
        //  그리고 페이지 컨트롤을 화면에 띄워주면 됩니다
    
        
     
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
  view.addSubview(imageView)
         imageView.image = UIImage(named: images[pageControl.currentPage])
        view.addSubview(agoBtn)
        view.addSubview(nextBtn)

    
    }

    //  컨텐츠 뷰컨을 만들어주는 메서드를 따로 만들어줬습니다
    //  그냥 뷰컨 하나를 생성하고 태그에 인덱스 번호를 넣어주고 배경색만 바꿔줬습니다
    private func instantiateViewController(index: Int, color: UIColor) -> UIViewController {
        let vc = UIViewController()
        vc.view.tag = index
        vc.view.backgroundColor = color
        return vc
    }
}

extension IntroViewController: UIPageViewControllerDataSource {
    
    //  이전 컨텐츠 뷰컨을 리턴해주시면 됩니다
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        
        //  컨텐츠 뷰컨을 생성할 때 태그에 인덱스를 넣어줬기 때문에 몇번째 페이지인지 바로 알 수 있어요
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        
        // 이전 인덱스를 계산해주고요
        let nextIndex = index > 0 ? index - 1 : backgroundColors.count - 1

        // 이전 컨텐츠를 담은 뷰컨을 생성해서 리턴해줍니다
        let nextVC = instantiateViewController(index: nextIndex, color: backgroundColors[nextIndex])
      
        imageView.image = UIImage(named:images[nextIndex])
       
        
        return nextVC
    }
    
    //  다음 컨텐츠 뷰컨을 리턴해주시면 됩니다. 위에 메서드랑 똑같은데 다음 컨텐츠를 담으면 돼요
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        
        guard let index = pageViewController.viewControllers?.first?.view.tag else {
            return nil
        }
        let nextIndex = (index + 1) % backgroundColors.count

        let nextVC = instantiateViewController(index: nextIndex, color: backgroundColors[nextIndex])
  
        
        imageView.image = UIImage(named:images[nextIndex])
        return nextVC
    }
}

extension IntroViewController: UIPageViewControllerDelegate {
    
    //  스와이프 제스쳐가 끝나면 호출되는 메서드입니다. 여기서 페이지 컨트롤의 인디케이터를 움직여줄꺼에요
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool
    ) {
        //  페이지 이동이 안됐으면 그냥 종료
        guard completed else { return }
        
        //  페이지 이동이 됐기 때문에 페이지 컨트롤의 인디케이터를 갱신해줍시다
        if let vc = pageViewController.viewControllers?.first {
            pageControl.currentPage = vc.view.tag
        }
    }
}
