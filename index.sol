// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Name {
    //被投票的人有多少个
    mapping (string => uint) piaoshu1;
    //投票的人都投给了谁
    mapping (address => string) who;
    //合约拥有者
    address public owner;
    //票数计数器
    uint256 public Boss;
    uint256  public People;
    uint256  public Teacher;
    uint256 public  Student;
    constructor() {
        owner = msg.sender;
        Boss=0; People=0;Teacher=0;Student=0;
    }
    function bossAdd() public {
        once();
        string memory _name= "Boss";
        require(owner != msg.sender , "admin not tou piao");
          who[msg.sender] = _name;
          piaoshu1[_name] = ++Boss;

    }
    function peopel() public{
        once();
        string memory _name= "People";
         require(owner != msg.sender , "admin not tou piao");
       who[msg.sender] = _name;
        piaoshu1[_name] = ++People;

    }
    function teacher() public{
        once();
        string memory _name= "Teancher";
         require(owner != msg.sender , "admin not tou piao");
         who[msg.sender] = _name;
        piaoshu1[_name] = ++Teacher;
    }


      function student() public{
        once();
        string memory name= "Student";
         require(owner != msg.sender , "admin not tou piao");
        who[msg.sender] = name;
        piaoshu1[name] = ++Student;
    }
    
   //查询投票者都投给了哪些人
   function chaxun(address _who) public view returns (string memory){
    return  who[_who];

   }
   //设置每个账户智能进行一次投票
   function once() private view  {
    require(bytes(who[msg.sender]).length == 0,"you tou guo piao le");
   }
}
