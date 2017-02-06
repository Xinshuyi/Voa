# Voa
An Open Source English Learning Application

#1 文章接口

limit 返回的条数 

http://english.avosapps.com/feed?&limit=20&s=englishnewss  最新 

http://english.avosapps.com/feed?&limit=2&maxId=201&s=englishnewss 加载更多
表示加载从messageId = maxId 开始的 limit 条数据

#2.音频接口

#2.1 VOA常速

maxid = 0最新数据  parentID 分类
http://apps.iyuba.com/iyuba/titleChangSuApi2.jsp?maxid=0&type=android&format=json&pages=1&pageNum=20&parentID=0 全部    
parentID 
0 全部
101美国
102非洲
103亚洲
104中东
105欧洲
106 科技
107 娱乐
108 经济
109健康


http://apps.iyuba.com/iyuba/textNewApi.jsp?voaid=5201&format=json 新闻正文

http://apps.iyuba.com/iyuba/textExamApi.jsp?voaid=5201&format=json 评测

#2.2 VOA慢速

VOA慢速
http://apps.iyuba.com/iyuba/titleApi2.jsp?type=iOS&format=json&maxid=0&pages=1&pageNum=10&parentID=0
parentID 
0 全部
1 美国
2 世界
3 生活
4 娱乐
5 健康
6 教务
7 商务
8 科技
9 历史
10 单词故事 

#2.单词Api

单词Api http://word.iyuba.com/words/apiWord.jsp?q=cavities

发音http://res.iciba.com/resource/amp3/oxford/0/3b/1b/3b1b2e9823f7c8cd6f6dddfb9750f9ae.mp3