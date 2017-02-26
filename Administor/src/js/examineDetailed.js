(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        domain: 'http://www.yinzishao.cn:8000',
        parentMsg:{
      		pd_id:0,
          name:'张先生',
          teacher_sex: '不限',
          learning_phase: '高中',
          aim:'提高成绩',
          subject:'数学',
          subject_other: '',
          grade:'高一',
          address:"大学城小洲",
          time:"周六上午",
          class_field: '成绩优良',
          teacher_method:"nice,细心",
          teacher_method_other: '',
          require:"上课要耐心细致，对孩子好",
          salary: '18/h',
          bonus: '100/月',
          deadline: '2016年12月23号',
          tel: '1234567891'
      	},
      	tutorMsg:{
      		tea_id: '',
          certificate_photo:'../img/user02.png',
          name:'张先生',
          subject:'数学',
          subject_other:'',
          grade:'高一',
          place:"天河",
          time:"周六上午",
          native_place:"天河",
          teacher_method:"nice,细心",
          teacher_method_other: '',
          expection:"上课要耐心细致",
          sex:'男',
          salary_bottom:20,
          salary_top:60,
          tel:1234567891,
          self_comment:'特别受学生喜欢',
          score: 'GDP棒棒',
          campus_major:'英语',
          teach_show_photo:['../img/user02.png','../img/user02.png','../img/user02.png']
      	},
      	status: {
      		isFeeInfo: false,
      		isLoading: false,
      		isParent: true,
      		isTeacher: true,
          isEnlargeImg: false,
          enlargeImg: '',
      	},
      	form: {
      		'select': 1,
          'id': 0,
          "user": 'teacher'
      	},
      	fee: Number,
      },
      ready: function(){
        this.setOption();
        if(this.form.select == 1){
          this.form.user = 'teacher';
        }else{
          this.form.user = 'parent';
        }
        this.renderData();
        this.status.isLoading = true;
      },
      methods:{
        setOption: function() {
          var search = location.search;
          if (search.indexOf("?") != -1) {
            search = search.substr(1, search.length).split("&");
            for (var i = 0, cell, length = search.length; i < length; i++) {
              cell = search[i].split('=');
              if(cell[0]=='select'){
                this.form.select = parseInt(cell[1]);
              }else{
                this.form.id = parseInt(cell[1]);
              }
            }
          }
        },
        renderData: function(){
          this.$http.post(this.domain+'/getInfo',{
            "id":this.form.id,
            "format":true,
            "user":this.form.user
          },{
          	crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
          	console.log(res.json());
            if(res.json().success == 0){
              console.log(res.json().error);
            }else{
              if(this.form.select == 1){
                var data = res.json();
                if(data.certificate_photo!=''&&data.certificate_photo!=null){
                  data.certificate_photo=this.domain+data.certificate_photo;
                }
                var photo=data.teach_show_photo,len = photo.length;
                if(len>0){
                 for(var i=0;i<len;i++){
                  photo[i]=this.domain+photo[i];
                 }
                }
                this.status.isParent = false;
                this.status.isTeacher = true;
                this.$set('tutorMsg',data);
              }else{
                this.status.isParent = true;
                this.status.isTeacher = false;
                var data = res.json();
                data.class_field=this.grade_level(data.class_field);
                this.$set('parentMsg',data);
              }
            }
          });
    	  },
        grade_level: function(key){
          switch(key){
            case 0:
              return '';
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
        onReturn: function(){
        	window.location.href = './examine.html?select='+this.form.select;
        },
        notExamine: function(){
          // setTimeout(function(){
          //   window.location.href = './examine.html?select='+this.form.select;
          // },2000);
          this.onExamine(0);
        },
        onUser:function(){
          window.location.href = './userAdministor.html';
        },
        onDeal: function(){
          window.location.href = './deal.html';
        },
        onOther: function(){
          window.location.href = './other.html';
        },
        YesExamine: function(){
          this.onExamine(1);
        },
        onExamine: function(num){
      		this.$http.post(this.domain+'/setPass', {
            "type":num,
            "user":this.form.user,
  					'id': this.form.id,
  				}, {
  					crossOrigin: true,
  					headers:{
  						'Content-Type':'application/json'	
  					}
  				}).then(function(res) {
  					console.log(res.json());
  					if (res.json().success == 0) {
  						console.log(res.json().error);
  					} else {
  					  // this.notExamine();
              this.onReturn();
  					}
  				});
        },
        showImg: function(index){
          this.status.enlargeImg = this.tutorMsg.teach_show_photo[index];
          this.status.isEnlargeImg = true;
        },
        closeImg: function(){
          this.status.isEnlargeImg = false;
        },
        // onSubmit: function(){
        //     this.$http.post('', {
      		// 		'fee': this.fee,
      		// 		'id': this.form.id,
      		// 	}, {
      		// 		emulateJSON:true,
      		// 		headers:{
      		// 			'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'	
      		// 		}
      		// 	}).then(function(res) {
      		// 		console.log(res.json());
      		// 		if (res.json().result == 1) {
      		// 			this.onReturn();

      		// 		} else {
      				
      		// 		}
      		// 	});
        // },
        // onClose: function(){
        // 	this.status.isFeeInfo = false;
        // }
      }
	});
})();