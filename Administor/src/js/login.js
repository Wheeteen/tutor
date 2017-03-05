(function(){
  // Vue.http.interceptors.push(function(request, next){
  //   request.credentials = true;
  //   next();
  // });
	var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        domain:'http://www.yinzishao.cn/',
        status:{
          isLoading: false,
          isSubmit: false,
          getWechat: false
        },
        hintData: {
    		  status: false,
    		  text: ''
    		},
        form:{
          username: '',
          password: ''
        }
      },
      ready: function(){
        this.status.isLoading = true;
      },
      computed: {
        isBtn: function(){
          if(this.form.username!==''&&this.form.password!==''){
            return false;
          }else{
            return true;
          }
        }
      },
      methods: {
        offHint: function() {
  		    this.hintData.status = false;
  		  },
        onSubmit: function() {
          if(this.form.username!==''&&this.form.password!==''){
            this.status.isSubmit = true;
            this.$http.post(this.domain+'loginAdmin',this.form, {
              crossOrgin: true,
              headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res) {
              console.log(res.json());
              var self = this;
              this.status.isSubmit = false;
              if (res.json().success == 1) {
                location.href = './userAdministor.html';
              } else {
                this.hintData.text = res.json().error;
                this.hintData.status = true;
                this.timer && clearTimeout(this.timer);
                this.timer=setTimeout(function(){
                  self.hintData.status = false;
                },2000);
              }
            });
          }else{
            return false;
          }   			
    		}
      }
	});
})();