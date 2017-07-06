# FLTableComponent for tableView and collectionView

[中文说明](https://github.com/gitkong/FLTableViewComponent/blob/master/README_CN.md)

## Introduce

A component for tableView and collectionView, which can greatly reduce your controller codes, also, you can set header or footer more easily

![Process](https://github.com/gitkong/FLTableViewComponent/blob/master/FLComponentDemo/Snip20170706_3.png)

## what can it do

![component](https://github.com/gitkong/FLTableViewComponent/blob/master/FLComponentDemo/component.gif)

## Requirements

swift3+ and xcode8+

## Installation

```ruby
pod "FLTableComponent"
```

## How To Use (Just give an example for tableView)

1. Create a controller which  inherit the class of FLTableComponentController Or Create FLTableViewHandler to handle it, you can check the implementation of FLTableComponentController，and it will show you how to use it

``` swift
class DemoViewController: FLTableComponentController {
  
}

```

2. Create a component which inherit of FLTableBaseComponent, and override some methods

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

3. set dataSource in controller

``` swift

var arr : Array<FLTableBaseComponent> = []
        
let component = DemoComponent.init(tableView: self.tableView)
let NibComponent = NibDemoComponent.init(tableView: self.tableView)

arr.append(component)
arr.append(NibComponent)
self.components = arr

```

## Custom Use

1. custom tableView style and rect

```swift
override var tableViewStyle: UITableViewStyle {
  return UITableViewStyle.grouped
}

override func customRect() -> CGRect {
  return self.view.bounds
}
```

2. override the method of register() to regist  custom cell、header or footer 

``` swift
override func register() {
  // if you need default register, call super
  //super.register()
  // regist your custom cell、header or footer
}
```

3. create custom header or footer for cell

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


4. custom header or footer of tableView 

```swift
override func headerView(of tableView: UITableView) -> UIView? {
  // return tableHeaderView
}
    
override func footerView(of tableView: UITableView) -> UIView? {
  // return tableFooterView
}
```

## Author

279761135@qq.com、[简书](http://www.jianshu.com/u/fe5700cfb223)、[My blog](https://gitkong.github.io)

## Thanks

[rickytan RTComponentTableView(Objective-C)](https://github.com/rickytan/RTComponentTableView)

## License

FLTableComponent is available under the MIT license. See the LICENSE file for more info.
