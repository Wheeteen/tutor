(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        // domain: 'http://www.shendaedu.com',
        domain: 'http://shaozi.beansonbar.cn',
        parentMsg:{},
      	tutorMsg:{},
      	status: {
      		isFeeInfo: false,
      		isLoading: false,
      		isParent: false,
      		isTeacher: false,
          isEnlargeImg: false,
          enlargeImg: '',
          isExamine: false,
          isOnFee: false
      	},
      	form: {
      		'select': 1,
          'id': 0,
          "user": 'teacher',
          'tea_id': '',
          'par_id':''
      	},
      	fee: Number,
        priFee: ''
      },
      ready: function(){
        this.setOption();
        var select = this.form.select;
        if(select == 1){
          this.form.user = 'teacher';
        }else if(select == 2){
          this.form.user = 'parent';
        }else{
          this.form.user = 'both';
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
              switch(cell[0]){
                case 'select':
                  this.form.select = parseInt(cell[1]);
                  break;
                case 'teaId':
                  this.form.tea_id = parseInt(cell[1]);
                  break;
                case 'parId':
                  this.form.par_id = parseInt(cell[1]);
                  break;
                case 'listId':
                  this.form.id = parseInt(cell[1]);
                  break;
                case "price":
                  this.priFee = parseFloat(cell[1]);
                  break;
              }
            }
          }
        },
        renderData: function(){
          var data = this.form,
              select = data.select,
              user = data.user,
              id = data.id,
              teaId = data.tea_id,
              parId = data.par_id;
          if(select!==3){
            this.getData(id,user); 
            this.status.isExamine = true;           
          }else{
            this.getData(parId,'parent');
            this.getData(teaId,'teacher');
            if(this.priFee!==''){
              // this.status.isExamine = false;
              this.status.isOnFee = true;
            }else{
              this.status.isExamine = true;
            }
          }
         
    	  },
        getData: function(id,user){
           this.$http.post(this.domain+'/getInfo',{
            "id":id,
            "format":true,
            "user":user
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
              if(user == "teacher"){
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
                this.status.isTeacher = true;
                this.$set('tutorMsg',data);
              }else{
                this.status.isParent = true;
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
          var select = this.form.select;
          if(select!==3){
            this.onExamine(0);
          }else{
            this.onOrderEx(0);
          }  
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
          var select = this.form.select;
          if(select!==3){
            this.onExamine(1);
          }else{
            this.status.isFeeInfo = true;
          }          
        },
        //审核老师简历和家长需求
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
        //审核订单
        onOrderEx: function(willing){
          var json,id=this.form.id;
          if(willing == 1){
            json={
              "oa_id":id,
              "price":this.fee,
              'willing': 1,
            }
          }else{
            json={
              "oa_id":id,
              'willing': 0,
            }
          }          
          this.$http.post(this.domain+'/makePriceAndApprove', json, {
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
        onSubmit: function(){
          this.onOrderEx(1);
        },
        onClose: function(){
        	this.status.isFeeInfo = false;
        },
        onFeeInfo: function(){
          this.status.isFeeInfo = true;
          this.fee = this.priFee;
        }
      }
	});
})();