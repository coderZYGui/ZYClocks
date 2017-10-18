# ZYClocks
Simple clock project

### 实现思路:

  1. (秒针) 根据CALayer创建一个secLayer,让secLayer旋转,默认是绕着锚点(0.5,0.5)旋转(中心),<br>
      显然要修改锚点的位置为secLayer的底部,因此设置锚点为(0.5,1).<br>
      
  2. 创建NSTimer对象,每1s做旋转操作.<br>
  
  2. 当secLayer旋转,要计算当前旋转度是多少  = 当前的时间 * 每秒旋转的度数.<br>
  
  3. 当前的时间, 要根据日历类(NSCalendar)来创建,然后获得当前的 时,分,秒等.<br>
  
  4. 角度转为弧度. #define angle2Rad(angle) ((angle) / 180.0 * M_PI).<br>
  
  注意: <br>
  
      1. 当计算时针角度时,应加上 当每一分钟时针应该走多少度.<br>
      
      2. 另外所有的旋转,缩放都是绕着锚点形变.<br>
