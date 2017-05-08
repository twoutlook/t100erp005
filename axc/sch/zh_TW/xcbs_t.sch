/* 
================================================================================
檔案代號:xcbs_t
檔案名稱:每月製程成本工時費用分攤統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcbs_t
(
xcbsent       number(5)      ,/* 企業編號 */
xcbsld       varchar2(5)      ,/* 帳別編號 */
xcbscomp       varchar2(10)      ,/* 法人組織 */
xcbs001       varchar2(10)      ,/* 成本計算類型 */
xcbs002       number(5,0)      ,/* 年度 */
xcbs003       number(5,0)      ,/* 期別 */
xcbs004       varchar2(10)      ,/* 成本中心 */
xcbs005       varchar2(1)      ,/* 費用分類(成本主要素) */
xcbs006       varchar2(10)      ,/* 工單編號 */
xcbs007       varchar2(1)      ,/* 分攤方式 */
xcbs008       varchar2(10)      ,/* 作業編號 */
xcbs009       number(10,0)      ,/* 作業序 */
xcbs100       number(20,6)      ,/* 工單分攤數 */
xcbs101       number(20,6)      ,/* 單位成本(本位幣一) */
xcbs111       number(20,6)      ,/* 單位成本(本位幣二) */
xcbs121       number(20,6)      ,/* 單位成本(本位幣三) */
xcbs202       number(20,6)      ,/* 分攤金額(本位幣一) */
xcbs212       number(20,6)      ,/* 分攤金額(本位幣二) */
xcbs222       number(20,6)      /* 分攤金額(本位幣三) */
);
alter table xcbs_t add constraint xcbs_pk primary key (xcbsent,xcbsld,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,xcbs006,xcbs007,xcbs008,xcbs009) enable validate;

create unique index xcbs_pk on xcbs_t (xcbsent,xcbsld,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,xcbs006,xcbs007,xcbs008,xcbs009);

grant select on xcbs_t to tiptop;
grant update on xcbs_t to tiptop;
grant delete on xcbs_t to tiptop;
grant insert on xcbs_t to tiptop;

exit;
