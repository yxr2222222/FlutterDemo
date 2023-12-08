# flutter_demo

一个Flutter基础框架Demo，[基础框架](https://github.com/yxr2222222/yxr_flutter_basic)为此项目

## Tips

1. Flutter Web项目加载速度优化。Flutter Web 项目主要有**canvaskit**和**html**两种渲染模式，默认是**canvaskit**，优点是体验更好，动画这些更顺滑，适合界面多、交互复杂的Web应用；**html**模式首屏加载速度较快，更适合一些简单的Web项目；
    1. **canvaskit渲染模式**，在web目录中的index.html中加入以下js。加载慢主要原因是需要加载canvaskit.wasm和canvaskit.js文件，以及一些字体文件：KFOmCnqEu92Fr1Me5WZLCzYlKw.ttf、k3kXo84MPvpLmixcA63oeALhL4iJ-Q7m8w.otf等，以下配置可让flutter不去远程下载canvaskit相关内容，而是使用自带的canvaskit；
       ```html
        <script>
            window.flutterConfiguration = {
                canvasKitBaseUrl: "canvaskit/"
            };
        </script>
        ```
    2. 在愿意降低一些用户体验的情况下，可以切换成**html渲染模式**，切换只需在web目录中的index.html中加入以下js即可；
        ```html
         <script>
            window.flutterWebRenderer = "html";
         </script>
       ```
    3. 在web目录中的index.html移除以下代码;
        ```html
        serviceWorker: {
            serviceWorkerVersion: serviceWorkerVersion,
        },
       ```

