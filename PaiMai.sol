// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract PaiMai{
    uint256 public  auctionToken = 1 ether;//最低起拍价
    address  onwer;//合约拥有者
    uint256 starttime;//开始时间
    uint256 endtime; //结束时间
    mapping (address => uint256) jiaoyizhe;
    //最高价者
    address public people =msg.sender;
    //最高金额
    uint256 public token = msg.value;
    constructor(){
        onwer = msg.sender;
        starttime = block.timestamp;
        endtime = starttime + 120;
       

    }
    //争标函数
    function Auction() public payable  {
        require(block.timestamp > starttime ,"hai wei dao pai mai shi jian");
        require(msg.value > auctionToken,"bu neng di yu qi pai jia");
        require(msg.value > token, "yi you ren chu le xiang tong de jia ge");
        require(block.timestamp < endtime,"pai mai yi jie shu");
        jiaoyizhe[msg.sender] = msg.value;
        people = msg.sender;
        token = msg.value;
       }
       
        
    //查看当前最高价函数
    function chakan() public view  returns (uint256 zuigaojia,address zuigaochujiazhe) {
            return (token,people);

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
         payable(onwer).transfer(address(this).balance);

    }
   
}