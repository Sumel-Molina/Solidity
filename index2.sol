// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Name {
    //被投票的人有多少个
    mapping (string => uint) piaoshu1;
    //投票的人都投给了谁
    mapping (address => string) who;
    //合约拥有者
    address  owner;
    uint256  Boss;
    uint256   People;
    uint256   Teacher;
    uint256   Student;
    uint256   startTime;
    constructor() {
        owner = msg.sender;
        Boss=0; People=0;Teacher=0;Student=0;
        startTime = block.timestamp;
    }
    modifier Time(){
        require(block.timestamp < startTime +60,"shi jian jie shu");
        _;
    }
    function bossAdd() public Time {
        once();
        string memory _name= "Boss";
        require(owner != msg.sender , "admin not tou piao");
          who[msg.sender] = _name;
          piaoshu1[_name] = ++Boss;

    }
    function peopel() public Time{
        once();
        string memory _name= "People";
         require(owner != msg.sender , "admin not tou piao");
       who[msg.sender] = _name;
        piaoshu1[_name] = ++People;

    }
    function teacher() public Time{
        once();
        string memory _name= "Teancher";
         require(owner != msg.sender , "admin not tou piao");
         who[msg.sender] = _name;
        piaoshu1[_name] = ++Teacher;
    }


      function student() public Time{
        once();
        string memory name= "Student";
         require(owner != msg.sender , "admin not tou piao");
        who[msg.sender] = name;
        piaoshu1[name] = ++Student;
    }
    
   //查询投票者都投给了哪些人
   function chaxunwho(address _who) public view returns (string memory){
    return  who[_who];

   }
   //设置每个账户智能进行一次投票
   function once() private view  {
    require(bytes(who[msg.sender]).length == 0,"you tou guo piao le");
   }
   //查询候选人票数
   function houxuanren(string memory _name)public view returns (uint256) {
       
      return  piaoshu1[_name];
   }
   //投票结束后查看备选人的票数
   function BeiXuan( ) public  view returns(uint256 bos,uint256 peo,uint256 Teac,uint256 Stu){
    require(block.timestamp >=startTime+30,"shi jian wei jie shu jing zhi cha kan piao shu");
    return (Boss,Teacher,People,Student);

   }
}