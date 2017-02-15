(function(){
	Vue.config.devtools = false;
    var localStorage = window.localStorage;
	var vm = new Vue({
		el: 'body',
		data:{
			status:{
				isSubmit: false,
				stId: false,
				isBtn: false,
				isLoading: false
			},
			hintData:{
				status: false,
                text: ''
			},
			form: {
				name: '',
				student: '',
				stId: '',
				agree: '',
			},
		},
		ready: function(){
		  
          this.status.isLoading = true;
		},
		watch: {
          "form.student":function(){
			this.status.stId = true;
		  }
		},
		methods: {			
			offHint: function(){
				this.hintData.status = false;
			},
            onSubmit: function(){
            	this.status.isSubmit = true;
            	this.$http.post('',{
            		'name': this.form.name,
            		'student': this.form.student,
            		'stId': this.form.stId,
            		'agree': this.form.agree
            	},{
					emulateJSON:true,
					headers:{
						'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'	
					}
				}).then(function(res,err){
					this.status.isSubmit = false;
					if (res.json().result == 1) {
						if(localStorage.getItem('id') == ''){
							localStorage.setItem('id',res.json().id);
							location.href = './teacherResume.html';
						}else{
                            location.href = './teacherPage.html';
						}
					} else {
						this.hintData.text = res.json().msg;
						this.hintData.status = true;
					}
				})
            }
		}
	});
	
})();