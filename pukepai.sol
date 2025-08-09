// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract DouDiZhu{
    address[] yonghu;
    uint num = 0;
    uint256 one;//第一张牌
    uint256 two;//第二张牌
    uint256 people;//参与人数
    address Zhuang;//获胜者
     bool started = false;
     address onwer ;
     mapping(address => uint256) yazhu;//押注，金额
     mapping (address => uint256) once;//第一张手牌
     mapping (address => uint256) twice;//第二张手牌
     mapping (address =>  uint256) chazhi;//两张手牌差值
   
   
   constructor(){
    onwer = msg.sender;
  
   }
     //
    function strat() public  payable   returns (string memory) {
        //满3个人才能开始游戏;
        require(msg.sender != address(0),"bu neng hcong fu can yu");
         require(msg.value >0 ,"YA ZHU BU NENG XIAO YU 0 ETH");   
          if(people == 3){
            started = true;
            return "you xi kai shi";
          }
          jilu(msg.sender);
         people += 1;
          yazhu[msg.sender] = msg.value;
         
          return  "Can yu cheng gong";
         
    }
    //获取牌大小
    function huodepai() public   returns(uint256 _once,uint256 _twice,uint256 _chazhi ){
             require(yazhu[msg.sender] >0,"ya zhu bu neng di yu 0 eth");
          require(started == true,"WEI MAN REN");
          require(yazhu[msg.sender] !=0, "yi can yu le chou pai");
          (_once,_twice) = getTwoRandomNumbers(msg.sender); 
      
          jilu(msg.sender);
           one = _once;
           two = _twice;
           once[msg.sender]  = one;
           twice[msg.sender] = two;
            chazhi[msg.sender] = once[msg.sender] - twice[msg.sender];
            return  (_once,_twice,_chazhi);
    }
    //获胜者结果
         function jieguo()public returns (string memory,address){

                      jisuan();
                     return  ("huo sheng zhe shi",Zhuang);
         }
    
        
  
    // 在一次调用中返回两个 1..13 的伪随机数（测试用）
    function getTwoRandomNumbers(address player) internal view returns (uint256 random1, uint256 random2) {
        uint256 seed = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, player)));

        random1 = (seed % 13) + 1;
        random2 = (uint256(keccak256(abi.encodePacked(seed, uint256(1))))) % 13 + 1;

        if (random2 == random1) {
            random2 = (uint256(keccak256(abi.encodePacked(seed, uint256(2))))) % 13 + 1;
        }

        return (random1, random2);
    }
   
//记录参与
uint o = 0;
function jilu(address _ADDRESS) private  {
       yonghu[o] = _ADDRESS;
       o++;
   
}
//获胜者提款函数
function WinTikuan() public   payable {
    require(msg.sender == Zhuang,"YOU ARE NOT WIN");
    
}
//平台提款函数
function pingtai() public payable  {
    require(msg.sender == onwer,"you are not admin");
   
        payable(onwer).transfer(address(this).balance);

}
//计算比赛结果
function jisuan() private  returns(uint256,address) {
  uint[]  memory zhi ;
   uint MAX;
 for(num =0;num<people;num++){
  if(once[yonghu[num]]>twice[yonghu[num]]){
    zhi[num] = once[yonghu[num]] - twice[yonghu[num]];
  }else{
    zhi[num] = twice[yonghu[num]] - once[yonghu[num]];
  }
 } 
 for(uint i=0;people-2 >=i;i++){
  for(uint j=1;j<people;j++){
    if(zhi[i]>zhi[j]){
        MAX = zhi[i];
         continue ;
    }else{
         MAX=zhi[j];
    }
  }
 }
 for(uint jk = 0;jk<people;jk++){
  if(chazhi[yonghu[jk]]==MAX){
    Zhuang =yonghu[jk];
      return (MAX,Zhuang);
  }else{
    continue ;
  }
 }

 return (0,onwer);
}


}
