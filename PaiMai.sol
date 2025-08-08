// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract PaiMai{
    uint256 public  auctionToken = 1 ether;//最低起拍价
    address  onwer;//合约拥有者
    bool starttime = false;//开始时间
    uint256 endtime; //结束时间
    mapping (address => uint256) jiaoyizhe;
    //最高价者
    address public people =msg.sender;
    //最高金额
    uint256 public token = msg.value;
    constructor(){
        onwer = msg.sender;
        }
        //开始按钮只有发布交易的人才能开始
    function started() public {
        require(msg.sender == onwer,"you are not admin");
         starttime = true;
         endtime = block.timestamp + 60;
    }
    //争标函数
    function Auction() public payable  {
        require(starttime == true ,"hai wei dao pai mai shi jian");
        require(msg.value > auctionToken,"bu neng di yu qi pai jia");
        require(msg.value > token, "yi you ren chu le xiang tong de jia ge");
        require(block.timestamp < endtime,"pai mai yi jie shu");
        //拍段这个用户是否是第一次出价
        if(people != address(0)){
            jiaoyizhe[people] +=token;
        }
        people = msg.sender;
        token = msg.value;
        //将用户加入哈希表

        
       }
       
    //退款函数
   function tuikuan() public payable  {
         require(msg.sender !=people && msg.sender != onwer, "cheng jiao zhe he admin bu neng tui kuan");
         require(block.timestamp > endtime,"pai mai wei jie shu ");
         uint256 amount = jiaoyizhe[msg.sender];
         require(amount >0 ,"ni mei you ke tui kuan");
           payable(msg.sender).transfer(amount);
   }


    //生成订单
    function dingdan() public   view  returns (address gainer,uint256 chengjaiojia,uint256 shijian){
        require(block.timestamp >= endtime,"shi jian hai wei jei shu");
          require(msg.sender == people,"NI BU SHI HUO DE ZHE");
           return (people,token,block.timestamp);
    }
    //提款函数
    function tikuan() public  payable {
        require(msg.sender == onwer,"ni mei you ti kuan quan xian");
        require(address(this).balance == token,"qi ta pai mai zhe wei tui kuan");
         payable(onwer).transfer(address(this).balance);

    }
   
}
