(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
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
          pwd: ''
        }
      },
      ready: function(){
        this.status.isLoading = true;
      },
      computed: {
        isBtn: function(){
          if(this.form.username!==''&&this.form.pwd!==''){
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
    			this.status.isSubmit = true;
    			this.$http.post(this.domain+'',this.form, {
    				crossOrgin: true,
    				headers:{
    					'Content-Type':'application/json'	
    				}
    			}).then(function(res) {
    				console.log(res.json());
    				this.status.isSubmit = false;
    				if (res.json().success == 1) {
    					location.href = './userAdministor.html';
    				} else {
    					this.hintData.text = res.json().msg;
    					this.hintData.status = true;
    				}
    			});
    		}
      }
	});
})();