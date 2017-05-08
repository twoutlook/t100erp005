/*
================================================================================
檔案代號:dzac_t
檔案名稱:欄位設定資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzac_t
(
dzac001       varchar2(20) NOT NULL,    /*程式代號                            */
dzac002       varchar2(10) NOT NULL,    /*版本                                */
dzac003       varchar2(15) NOT NULL,    /*Table代號                           */
dzac004       varchar2(30) NOT NULL,    /*欄位代號                            */
dzac005       varchar2(1) NOT NULL,     /*必要欄位:Y/N                        */
dzac006       varchar2(1) NOT NULL,     /*是否主鍵:Y/N                        */
dzac007       varchar2(255),            /*預設值                              */
dzac008       varchar2(1) NOT NULL,     /*是否唯讀:Y/N                        */
dzac009       varchar2(1) NOT NULL,     /*可新增:Y/N                          */
dzac010       varchar2(1) NOT NULL,     /*可修改:Y/N                          */
dzac011       varchar2(1) NOT NULL,     /*可查詢:Y/N                          */
dzac012       varchar2(255),            /*資料項目                            */
dzac013       varchar2(30),             /*開窗設定                            */
dzac014       varchar2(30),             /*檢查存在                            */
dzac015       varchar2(30),             /*不存在時的訊息                      */
dzac016       varchar2(30),             /*檢查重複                            */
dzac017       varchar2(30),             /*重複時的訊息                        */
dzac018       varchar2(50),             /*資料範圍                            */
dzac019       clob,                     /*規格內容                            */
dzac020       varchar2(1) NOT NULL,     /*是否有BEFORE FIELD校驗:Y/N          */
dzac021       varchar2(1) NOT NULL,     /*是否有ON CHANGE校驗:Y/N             */
dzac022       varchar2(1) NOT NULL,     /*是否有OPEN WINDOW設定:Y/N           */
dzac023       varchar2(1) NOT NULL,     /*是否有AFTER FIELD校驗:Y/N           */
dzac024       varchar2(1) NOT NULL,     /*是否複製:Y/N                        */
dzac025       varchar2(1) NOT NULL      /*資料瀏覽設定:Y/N                    */
);
alter table dzac_t add constraint dzac_pk primary key (dzac001,dzac002,dzac004) enable validate;
grant select on dzac_t to tiptopgp;
grant update on dzac_t to tiptopgp;
grant delete on dzac_t to tiptopgp;
grant insert on dzac_t to tiptopgp;
grant index on dzac_t to tiptopgp;
grant index on dzac_t to public;
grant select on dzac_t to ods;
