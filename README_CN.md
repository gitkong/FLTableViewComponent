# FLTableComponent for tableView and collectionView

## 简单介绍

一个tableView和collectionView的组件话实现，解耦控制器，类似MVVM的方式瘦身控制器，搭建复杂界面的代码更加清晰容易维护

## 能干嘛，看下图

![component](https://github.com/gitkong/FLTableViewComponent/blob/master/FLComponentDemo/component.gif)

## 要求

swift3+ and xcode8+

## 安装

```ruby
pod "FLTableComponent"
```

## 如何使用 (下面只介绍tableView，collectionView同理)

1. 有两种方式，你可以直接创建一个控制器继承自FLTableComponentController，或者直接创建FLTableViewHandler去处理，至于如何使用handler，可以参考FLTableComponentController的内部实现

``` swift
class DemoViewController: FLTableComponentController {
  
}

```

2. 创建一个 component继承自 FLTableBaseComponent, 并实现里面相关方法，具体可参考Demo

``` swift
class DemoComponent: FLTableBaseComponent {

  override func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
    let cell : UITableViewCell = super.cellForRow(at: indexPath)
    return cell
}

  override func numberOfRows() -> NSInteger {
      return 2
  }

  ...

}

```

3. 设置数据源

``` swift

var arr : Array<FLTableBaseComponent> = []
        
let component = DemoComponent.init(tableView: self.tableView)
let NibComponent = NibDemoComponent.init(tableView: self.tableView)

arr.append(component)
arr.append(NibComponent)
self.components = arr

```

## 重写修改tableView相关信息（前提是你直接继承FLTableComponentController）

1. custom tableView style and rect

```swift
override var tableViewStyle: UITableViewStyle {
  return UITableViewStyle.grouped
}

override func customRect() -> CGRect {
  return self.view.bounds
}
```

2. 在component里面重写 register() 去注册自定义cell、header 或 footer 

``` swift
override func register() {
  // if you need default register, call super
  //super.register()
  // regist your custom cell、header or footer
}
```

3. 创建对应section的header 和 footer，以及赋值操作

```swift

override func headerView(at section: Int) -> FLTableViewHeaderFooterView? {
  // you should call super to get headerView if you just regist the class of FLTableViewHeaderFooterView;
  // if you override the method of register() to regist the subclass of FLTableViewHeaderFooterView, you can not call super to get headerView,
  // and you should call init(reuseIdentifier: String?, section: Int) and addClickDelegete(for headerFooterView : FLTableViewHeaderFooterView?)
  // if this headerView have to accurate tapping event
}
    
override func additionalOperationForReuseHeaderView(_ headerView: FLTableViewHeaderFooterView?) {
  // do some additional operations, at usual, you add label or button or something else into header view to resue
  // but if you had registed the class of FLTableViewHeaderFooterView for footerView, this method will be invalid.
  //so if you want it to be valiable, do not call super when you override register() method
}
    
override func heightForHeader(at section: Int) -> CGFloat {
  // return height for header
}
    
override func footerView(at section: Int) -> FLTableViewHeaderFooterView? {
  // the same as header
}
    
override func additionalOperationForReuseFooterView(_ footerView: FLTableViewHeaderFooterView?) {
  // the same as header
}
    
override func heightForFooter(at section: Int) -> CGFloat {
    // return height for footer
}

```


4. 在控制器中自定义tableView 的headerView 和 footerView 

```swift
override func headerView(of tableView: UITableView) -> UIView? {
  // return tableHeaderView
}
    
override func footerView(of tableView: UITableView) -> UIView? {
  // return tableFooterView
}
```

## 作者

279761135@qq.com、[简书](http://www.jianshu.com/u/fe5700cfb223)、[My blog](https://gitkong.github.io)

## 参考

[rickytan RTComponentTableView(Objective-C)](https://github.com/rickytan/RTComponentTableView)

## License

FLTableComponent is available under the MIT license. See the LICENSE file for more info.
