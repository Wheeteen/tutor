function dateCompare(date1, date2) {
  if (date1.day && date2.day) {
    return date1.year > date2.year ||
      (date1.year == date2.year && date1.month > date2.month) ||
      (date1.year == date2.year && date1.month == date2.month && date1.day >= date2.day);
  } else {
    return date1.year > date2.year || (date1.year == date2.year && date1.month > date2.month);
  }
}
(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        domain: 'http://shaozi.beansonbar.cn/',
        timer: null,
        calendar:{
          year: 0,
          month: 0,
          day: 0,
          days: [],
          today: [],
          currentMonth: Number,
          monthString:"",
          weeks: ['日', '一', '二', '三', '四', '五', '六'],
          months: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
          show: false,
          type: 'date',
          value: '',
          sep:'-',
        },
        status:{         
        	tipQuestion: true,
        	Q1: true,
        	Q2: false,
        	Q3: false,
        	Q4: false,
        	Q5: false,
        	Q6: false,
        	Q7: false,
        	Q8: false,
          isSelected: true,
          isAllowanceTip: false,
          isPrice: false,
          isSubmit: false,
          textTip: '',
          isLoading: false,
          isOtherTutorChar: false,
          // getLocation: false,
          textUsername: '',
          textAddress: '',
          getTip: false,
          errorTip: '',

        },
        learning_phase:[{
          value: [
           {'tag':'小学','key':2},
           {'tag':'初中','key':3},
           {'tag':'高中','key':4},
           {'tag':'幼升小','key':1},
           {'tag':'其他','key':0},
          ]
        },{
          value: [
            "一年级","二年级","三年级","四年级","五年级","六年级"
          ]
        },{
          value: ["一年级","二年级","三年级"]
        },{
          value:[
            {'tag':'名列前茅','key':5},
            {'tag':'中上水平','key':4},
            {'tag':'中等水平','key':3},
            {'tag':'中等偏下','key':2},
            {'tag':'较为靠后','key':1}
          
          ]
        }
        ],
        question:[
         {key:'Q1'},{key:'Q2'},{key:'Q3'},{key:'Q4'},{key:'Q5'},{key:'Q6'},{key:'Q7'},{key:'Q8'}
        ],
        formGroup:[{
          value: [
            {"tag":"数学"},           
            {"tag":"英语"},
            {"tag":"语文"},
            {"tag":"物理"},
            {"tag":"化学"},
            {"tag":"生物"},
            {"tag":"奥数"},
            {"tag":"音乐"},
            {"tag":"美术"},
            {"tag":"全科"},
          ]
        },{
          value: [
            {"tag":"升学考"},{"tag":"择校"},{"tag":"打基础"},
            {"tag": "拔高"},{"tag":"提高学习兴趣和方法","key":true},{"tag":"陪读"},
            {"tag":"其他"}
          ],
        },{
          value: [
           {"key": 'Mon',"tag": "周一",'begin':'mon_begin','end':'mon_end'},{"key": "Tue","tag": "周二",'begin':'tues_begin','end':'tues_end'},{"key": 'Wed',"tag": "周三",'begin':'wed_begin','end':'wed_end'},{"key": "Thr","tag": "周四",'begin':'thur_begin','end':'thur_end'},{"key": "Fri","tag": "周五",'begin':'fri_begin','end':'fri_end'},
          ],
        },{
          value: {          
            "Sat":{
              "tag": "周六",
              "key": [{'tag':'sat_morning'},{'tag':'sat_afternoon'},{'tag':'sat_evening'}]
            },
            "Sun": {
              "tag": "周日",
              "key": [{'tag':'sun_morning'},{'tag':'sun_afternoon'},{'tag':'sun_evening'}]
            }
          },          
           
        },{
          value: {
            "sex":{
              "model": 'teacher_sex',
              "tag": "老师性别",
              "key": [{
                'key':'不限','num':0
              },{
                'key':'男老师','num':1
              },{
                'key':'女老师','num':2
              }]
            },
            "char":{
              "model": 'teacher_method_arr',
              "tag": "教学特点",
              "key": ["严厉要求","氛围轻松","亲和力强","其他"]
            }
          }

        }
        ],
        salary:'',
        grade:["一年级","二年级","三年级","四年级","五年级","六年级"],
        Arr: {
          subjectArr: [],
          teacher_method_arr: [],
          aimArr: [],
          allowance:''
        },
        form:{
        	'subject': '',
        	'subject_other': '',
        	'aim': '',
        	'teacher_sex': 0,
        	'teacher_method': '',
          'teacher_method_other':'',
        	'learning_phase':2,
        	'class_field': 0,
          'grade':'一年级',
          'require':'',
          'salary': Number,
          'allowance_not':0,
          'bonus': '',
          'name': '',
          'tel': '',
          'address': '',
          'deadline':'',
          'weekend_tutor_length': Number,
          'mon_begin':'',
          'mon_end': '',
          'tues_begin':'',
          'tues_end': '',
          'wed_begin': '',
          'wed_end': '',
          'thur_begin': '',
          'thur_end': '',
          'fri_begin': '',
          'fri_end': '',
          'sat_morning': 0,
          'sat_afternoon': 0,
          'sat_evening': 0,
          'sun_morning': 0,
          'sun_afternoon':0,
          'sun_evening': 0,
        },
        time:{
          Mon: [],
          Tue: [],
          Wed: [],
          Thr: [],
          Fri: [],
        },
        location:{
          latitude:'',
          longitude:'',
          // speed:'',
          // accuracy:'',
        },
        signature: '',
      },
      created: function(){
        this.init();
        var self = this;
        // 延迟绑定事件，防止关闭
        window.setTimeout(function(){
          document.addEventListener('touchstart', function(e){
            e.stopPropagation();
            self.cancel();
          }, false)
        }, 500)
      },
      computed: {
        grade_level: function(){
          switch(this.form.class_field){
            case 0:
              return '请选择';
            case 1:
              return '较为靠后';
            case 2: 
              return '中等偏下';
            case 3:
              return '中等水平';
            case 4:
              return '中上水平';
            case 5: 
              return '名列前茅';
          }
        },
        isBtnSuccess1: function(){
          if(this.Arr.subjectArr.length!==0||(this.form.subject_other!==''&&this.form.subject_other!=null)){
            return true;
          }else{
            return false;
          }
        },
        isBtnSuccess2: function(){
          if(this.Arr.aimArr.length!==0){
            return true;
          }else{
            return false;
          }
        },
        isBtnSuccess3: function(){
          if(this.time.Mon.length>0||this.time.Tue.length>0||this.time.Wed.length>0||this.time.Thr.length>0||this.time.Fri.length>0||this.form.sun_morning == true||this.form.sun_afternoon==true||this.form.sun_evening==true||this.form.sat_morning==true||this.form.sat_afternoon==true||this.form.sat_evening==true){
            return true;
          }else{
            return false;
          }
        },
        isBtnSuccess4: function(){
          if(this.form.teacher_sex!=null||this.Arr.teacher_method_arr.length!==0){
            return true;
           }else{
            return false;
           }
        },
        isBtnSuccess6: function(){
          if(this.form.require!==''&&this.form.require!=null){
            return true;
          }else{
            return false;
          }
        },
        isBtnSuccess7: function(){
          if(this.form.salary!=Number&&this.form.salary!=null){
            return true;
          }else{
            return false;
          }
        },
        isBtnSuccess8: function(){
          if(this.form.name!==''&&this.form.address!==''&&this.form.tel!==''&&this.form.name!=null&&this.form.address!=null&&this.form.tel!=null){
            return true;
          }else{
            return false;
          }
        },
        coachTime: function(){
          var day = this.form;
          if(day.sun_morning == true||day.sun_afternoon==true||day.sun_evening==true||day.sat_morning==true||day.sat_afternoon==true||day.sat_evening==true){
            return true;
          }else{
            return false;
          }
        }

      },
      watch:{
        'form.learning_phase':function(){
          this.onSelect();
        },
        'Arr.allowance': function(res){
          if(res == true){
            this.form.allowance_not = 1;
            this.status.isAllowanceTip = true;
          }else{
            this.form.allowance_not = 0;
            this.status.isAllowanceTip = false;
          }
        },
        'calendar.value': function (value) {
          this.form.deadline=value;
        },
        'Arr.subjectArr':function (res){
          if(res.length>1){
            this.form.subject= res.join(",");
          }else{
            this.form.subject = res[0];
          }
        },
        
        'Arr.aimArr':function (res){
          if(res.length>1){
            this.form.aim= res.join(",");
          }else{
            this.form.aim = res[0];
          }
        },
        
        'Arr.teacher_method_arr':function (res){
          for(var i =0;i<this.Arr.teacher_method_arr.length;i++){
            if(res[i] == '其他'){
              this.status.isOtherTutorChar = true;
            }
          }
          if(res.length>1){
            this.form.teacher_method= res.join(",");
          }else{
            this.form.teacher_method = res[0];
          }
        },         
      },
      ready: function(){
        this.getData();
        if(this.getParam()){
          this.status.tipQuestion = false;
          this.renderData();
        }else{
          this.status.tipQuestion = true;
        }
        this.status.isLoading = true;
        
      },
      methods: {
        getData:function(){
          this.$http.post(this.domain+'getText',{
            'key':["salary"]
          },{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            if(res.json().success == 1){
              this.salary = res.json().salary;
            }else{
              console.log(res.json().error);
            }
          })
        },
        getParam: function(){
           var str = location.search;
           if (str.indexOf("?") == -1) return 0;
           else return 1;
        },
        renderData: function(){
          this.$http.post(this.domain+'getParentInfo',{
            'pd_id':'',
            'format':''
          },{
              crossOrigin:true,
               headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res){
              console.log(res.json());
              this.$set('form',res.json());
              var subject = this.form.subject,
                  aim = this.form.aim,
                  method = this.form.teacher_method,
                  allowance = this.form.allowance_not,
                  mon = this.form.mon_end,
                  tues = this.form.tues_end,
                  wed = this.form.wed_end,
                  thur = this.form.thur_end,
                  fri = this.form.fri_end;
              if(subject!==null && subject!==''){
                this.getArr(subject,'subjectArr');
                
              }
              if(aim!==null&&aim!==''){
                this.getArr(aim,'aimArr');
              }
              if(method!==null&&method!==''){
                this.getArr(method,'teacher_method_arr');
              }
              if(allowance == 1){
                this.Arr.allowance = true;
              }else{
                this.Arr.allowance = false;
              }
              if(mon!==null&&mon!==''){
                this.getTimePeriod('mon_begin',mon,'Mon');
              }
              if(tues!==null&&tues!==''){
                this.getTimePeriod('tues_begin',tues,'Tue');
              }
              if(wed!==null&&wed!==''){
                this.getTimePeriod('wed_begin',wed,'Wed');
              }
              if(thur!==null&&thur!==''){
                this.getTimePeriod('thur_begin',thur,'Thr');
              }
              if(fri!==null&&fri!==''){
                this.getTimePeriod('fri_begin',fri,'Fri');
              }
            
          })
        },
        getArr: function(sub,subArr){
            if(sub.indexOf(",") == -1){
              this.Arr[subArr].push(sub);
            }else{
             this.Arr[subArr]=sub.split(","); 
            }
        },
        getTimePeriod: function(begin,end,arr){
           for(var i = this.form[begin];i<=end;i++){
             this.time[arr].push(i);
           }
        },
        //获取signature
        getSignature: function(){        
          this.$http.post(this.domain+'generate_signature',{
            "timestamp": 1482652615,
            "nonceStr": 'yinzishao',
          },{
            crossOrigin:true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            console.log(res.json());
            if(res.json().success == 1){
              this.signature = res.json().signature;
              var self = this;
              wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: 'wx7a327445ac3309b4', // 必填，公众号的唯一标识
                timestamp: 1482652615, // 必填，生成签名的时间戳
                nonceStr:'yinzishao' , // 必填，生成签名的随机串
                signature: self.signature,// 必填，签名，见附录1
                jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
              });
              this.timer && clearTimeout(this.timer);
              this.timer = setTimeout(function(){
                self.onAllow();
              }, 300);
              // this.status.getLocation = true;
            }else{
              console.log(res.json().error);
            }
            
          })                
        },
        zero: function(n){
          return n < 10 ? '0' + n : n;
        },
        init: function(){
          var now = new Date();
            if (this.calendar.value != "") {
                if (this.calendar.value.indexOf("-") != -1) this.calendar.sep = "-"
                if (this.calendar.value.indexOf(".") != -1) this.calendar.sep = "."
                if (this.calendar.value.indexOf("/") != -1) this.calendar.sep = "/"
                var split = this.calendar.value.split(this.calendar.sep)
                this.calendar.year = parseInt(split[0])
                this.calendar.month = parseInt(split[1]) - 1
                this.calendar.day = parseInt(split[2])
                             
            } else {
                if(this.calendar.sep=="")this.calendar.sep = "/"
                this.calendar.year = now.getFullYear()
                this.calendar.month = now.getMonth()
                this.calendar.day = now.getDate()
            }
            this.calendar.monthString=this.calendar.months[this.calendar.month]
            this.render(this.calendar.year, this.calendar.month)
        },
        //渲染日期
        render: function(y,m){
            var firstDayOfMonth = new Date(y, m, 1).getDay()         //当月第一天
            var lastDateOfMonth = new Date(y, m + 1, 0).getDate()    //当月最后一天
            var lastDayOfLastMonth = new Date(y, m, 0).getDate()     //最后一月的最后一天
            this.calendar.year = y
            this.calendar.currentMonth = this.calendar.months[m]
            var seletSplit = this.calendar.value.split(" ")[0].split(this.calendar.sep)
            var i, line = 0,temp = []
            for (i = 1; i <= lastDateOfMonth; i++) {
                var dow = new Date(y, m, i).getDay()
                // 第一行
                if (dow == 0) {
                    temp[line] = []
                } else if (i == 1) {
                    temp[line] = []
                    var k = lastDayOfLastMonth - firstDayOfMonth + 1
                    for (var j = 0; j < firstDayOfMonth; j++) {
                        temp[line].push({
                            day: k,
                            disabled: true
                        })
                        k++;
                    }
                }             
                // 单选模式
                var chk = new Date(),self = this;
                var chkY = chk.getFullYear();
                var chkM = chk.getMonth();
                var chkD = chk.getDate();
                var curDate = {
                'year': chkY,
                'month': self.zero(chk.getMonth()+1),
                'day': self.zero(chk.getDate())
              }
              var selectDate = {
                'year': self.calendar.year,
                  'month': self.zero(self.calendar.month + 1),
                  'day': self.zero(i)
              }
              var compare = dateCompare(selectDate,curDate);
                // 匹配上次选中的日期
                if (
                    parseInt(seletSplit[0]) == this.calendar.year &&
                    parseInt(seletSplit[1]) - 1 == this.calendar.month &&
                    parseInt(seletSplit[2]) == i) {
                    temp[line].push({
                        day: i,
                        selected: true
                    })
                    this.calendar.today = [line, temp[line].length - 1]
                }
                 // 没有默认值的时候显示选中今天日期
                else if (chkY == this.calendar.year && chkM == this.calendar.month && i == this.calendar.day && this.calendar.value == "") {
                    temp[line].push({
                        day: i,
                        selected: true
                    })
                    this.calendar.today = [line, temp[line].length - 1]
                }else{
                    // 设置可选范围
                     if(compare){
                        temp[line].push({
                          day: i,
                          selected: false
                      })
                     }else{
                      temp[line].push({
                          day: i,
                          disabled: true
                      })
                     }
                }            
                // 最后一行
                if (dow == 6) {
                    line++
                } else if (i == lastDateOfMonth) {
                    var k = 1
                    for (dow; dow < 6; dow++) {
                        temp[line].push({
                            day: k,
                            disabled: true
                        })
                        k++
                    }
                }
            } //end for
            this.calendar.days = temp
        },
        //上月
        prev: function(e){
           e.stopPropagation()
            if (this.calendar.month == 0) {
                this.calendar.month = 11
                this.calendar.year = parseInt(this.calendar.year) - 1
            } else {
                this.calendar.month = parseInt(this.calendar.month) - 1
            }
            this.calendar.monthString=this.calendar.months[this.calendar.month]
            this.render(this.calendar.year, this.calendar.month)
        },
        //下月
        next: function(e){
          e.stopPropagation()
            if (this.calendar.month == 11) {
                this.calendar.month = 0
                this.calendar.year = parseInt(this.calendar.year) + 1
            } else {
                this.calendar.month = parseInt(this.calendar.month) + 1
            }
            this.calendar.monthString=this.calendar.months[this.calendar.month]
            this.render(this.calendar.year, this.calendar.month)
        },
        //选中日期
        select: function(k1,k2,e){
          if (e != undefined) e.stopPropagation()
                // 日期范围          
                // 取消上次选中
            if (this.calendar.today.length > 0) {
                this.calendar.days.forEach(function(v){
                    v.forEach(function(vv){
                        vv.selected= false
                    })
                })
                 // this.days[this.today[0]][this.today[1]].selected = false
            }
            // 设置当前选中天          
          this.calendar.days[k1][k2].selected = true
            this.calendar.day = this.calendar.days[k1][k2].day
            this.calendar.today = [k1, k2]
            this.calendar.value = this.calendar.year + this.calendar.sep + this.zero(this.calendar.month + 1) + this.calendar.sep + this.zero(this.calendar.days[k1][k2].day)
            this.calendar.show = false       
        },
        // 隐藏控件
        cancel: function() {
          this.calendar.show = false
        },
        // 打开显示选择器
        open: function(e) {
            this.calendar.show=true
            // this.calendar.x=e.target.offsetLeft
            // this.calendar.y=e.target.offsetTop
        },
        onStart:function(){
        	this.status.tipQuestion = false;
        },
        onNext:function(index1,index2){      
          this.status[index1] = false;
          this.status[index2] = true;
        },
        onPre: function(index1,index2){
          this.status[index2] = false;
          this.status[index1] = true;        
        },
        
        onSubmit1: function(){
        	if(this.Arr.subjectArr.length!==0||(this.form.subject_other!==''&&this.form.subject_other!=null)){
        		this.onNext(this.question[0].key,this.question[1].key);
        	}else{
        		return false;
        	}
        },
        onSubmit2:function(){
          if(this.Arr.aimArr.length!==0){
        		this.onNext(this.question[1].key,this.question[2].key);
        	}else{
        		return false;
          }
        },
        onSubmit3: function(){
          if(this.time.Mon.length>0||this.time.Tue.length>0||this.time.Wed.length>0||this.time.Thr.length>0||this.time.Fri.length>0||this.form.sun_morning == true||this.form.sun_afternoon==true||this.form.sun_evening==true||this.form.sat_morning==true||this.form.sat_afternoon==true||this.form.sat_evening==true){
            this.onNext(this.question[2].key,this.question[3].key);
          }else{
            return false;
          }
        },
        onSubmit4:function(){
           if(this.form.teacher_sex!=null||this.Arr.teacher_method_arr.length!==0){
        		this.onNext(this.question[3].key,this.question[4].key);
        	 }else{
        		return false;
           }
        },
        onSubmit6: function(){
          if(this.form.require!==''&&this.form.require!=null){
            this.onNext(this.question[5].key,this.question[6].key);
          }else{
            return false;
          }
        },
        onSubmit7: function(){
          if(this.form.salary!=Number){
            this.onNext(this.question[6].key,this.question[7].key);
          }else{
            return false;
          }
        },
        onSelect: function(){
        	switch(this.form.learning_phase){
        		case 2:
        		    this.status.isSelected = true;
        		    this.grade=this.learning_phase[1].value;
                this.form.grade = '一年级';
        		    break;
        		case 3:
        		case 4:
        		    this.status.isSelected = true;
        		    this.grade=this.learning_phase[2].value;
        		    this.form.grade='一年级';
        		    break;
        		case 1:
        		case 0:
                this.status.isSelected = false;
        	}
        },
        
        onWeekday:function(day,index,begin,end){          
          var time = this.time,
              form = this.form;
          if(time[day].length==0){
            //第一次点
              form[begin]=index; 
              form[end]=index;  
          }               
          if(time[day].length>=1){
             if(index> form[end]){
                form[end] = index;  
                time[day] = [];
                for(var i =  form[begin];i<form[end];i++){
                  time[day].push(i);
                }       
              }else if(index> form[begin]&&index<form[end]){
                form[end] = index;  
                time[day] = [];
                for(var i =  form[begin];i<form[end];i++){
                  time[day].push(i);
                }       
              }
              else if(index == form[begin]){
                form[end] =  form[begin];
                time[day] = [];
                for(var i =  form[begin];i<=form[end];i++){
                  time[day].push(i);
                }
                form[begin]='';
                form[end]='';
              }
              else if(index< form[begin]&& form[begin]< form[end]){
                form[begin] = index;   
                time[day] = [];
                for(var i =form[begin]+1;i<= form[end];i++){
                  time[day].push(i);
                } 
              } 
            }
            console.log(time[day]);
        }, 
        clickPrice: function(){
          this.status.isPrice = true;

        },
        onClosePrice: function(){
          this.status.isPrice = false;
        },
        onStartLoaction: function(){
          if(this.form.name== ''){
            this.status.textUsername = '姓名不能为空';
            return false;
          }else if(this.form.tel == ''){
            this.status.textUsername = '';
            this.status.textTip = '手机号码不能为空';
            return false;
          }else if(!(/^1[34578]\d{9}$/.test(this.form.tel))){
            this.status.textTip = "请填写正确的手机号码";
            return false;
          }else if(this.form.address == ''){
            this.status.textTip = '';
            this.status.textAddress = '地址不能为空';
            return false;
          }else{
            this.status.textAddress = '';
            this.status.textUsername = '';
            this.status.textTip = '';
            if(this.getParam()){
              this.onSubmitQuestion('updateParentOrder');
            }else{
              this.onSubmitQuestion('createParentOrder');
              // this.getSignature();
              // this.configuration();
              // this.wxReady();
              // this.status.getLocation = true;
            }
          }
        },
        onSubmitQuestion: function(keyword){ 
          var self = this;
          this.status.isSubmit = true;       
          this.$http.post(this.domain+keyword,this.form, {
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res) {
            console.log(res.json());
            this.status.isSubmit = false;
            if (res.json().success == 1) {
              self.status.errorTip = '成功提交';
              self.status.getTip = true;
              if(keyword=='createParentOrder'){
                this.getSignature();
                self.status.getTip = false;
              }else{
                this.timer && clearTimeout(this.timer);
                this.timer=setTimeout(function(){
                  self.status.getTip = false;
                  location.href = './parentMyPage.html';
                },1000);
              }
            } else {
              self.status.errorTip = res.json().error;
              self.status.getTip = true;
              this.timer && clearTimeout(this.timer);
              this.timer=setTimeout(function(){
               self.status.getTip = false;
              },2000);
            }
          });
          
        },
        onLocation: function(){
          this.$http.post(this.domain+'setLocations',this.location,{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            if(res.json().success == 1){
              // this.status.getLocation = false;
              // this.onSubmitQuestion('createParentOrder');
              location.href = './parentPage.html';
            }
          })
        },
        onAllow: function(){
          var self = this;
          wx.ready(function (){
            wx.getLocation({
              type: 'wgs84',
              success: function (res) {
                self.location.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                self.location.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                self.onLocation();
              },
            });
          })
           
        },
        // onCancel: function(){
        //   // this.getSignature();
        //   // this.configuration();
        //   this.status.getLocation = false;
        //   this.onSubmitQuestion('createParentOrder');
        // },
      }
	});
	
})();