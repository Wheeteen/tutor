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
        status:{
          isLoading: false,
          isSubmit: false
      	},
        form:{
        	salary: '',
        	notice: ''
        },
        
      },
      ready: function(){
         this.getData();
         this.status.isLoading = true;
      },
      methods: {
      	getData: function(){
          this.$http.post(this.domain+'getText',{
            "key": ["salary","notice"]
          },{
          	crossOrigin: true,
            headers:{
            'Content-Type':'application/json' 
           }
          }).then(function(res){
          	console.log(res.json());
            if(res.json().success == 1){
              this.form.salary = res.json().salary;
              this.form.notice = res.json().notice;
            }else{
              console.log(res.json().error);
            }          	
          });
      	},
        onReturn: function(){
          window.location.href='./other.html';
        },
      	onUser:function(){
      		window.location.href = './userAdministor.html'
      	},
      	onDeal: function(){
          window.location.href = './deal.html';
      	},
      	onOther: function(){
          window.location.href = './other.html';
      	},
      	onSubmit: function(){
          if(this.form.salary!=''&&this.form.notice!=''){
            this.$http.post(this.domain+'changeText', this.form, {
              crossOrigin: true,
              headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res) {
              var self = this;
              if (res.json().success == 1) {
                this.status.isSubmit= true;
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                   this.status.isSubmit= false;
                }, 1000);
              }else{
                console.log(res.json().error);
              }
            });
          }	
      	}
      }
	});
})();