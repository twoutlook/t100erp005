/* 
================================================================================
檔案代號:mmau_t
檔案名稱:會員卡儲值異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmau_t
(
mmauent       number(5)      ,/* 企業編號 */
mmau001       varchar2(30)      ,/* 會員卡號 */
mmau002       varchar2(30)      ,/* 會員編號 */
mmau003       varchar2(10)      ,/* 異動來源 */
mmau004       varchar2(10)      ,/* 異動類別 */
mmau005       varchar2(20)      ,/* 異動交易單號 */
mmau006       timestamp(0)      ,/* 異動日期 */
mmau007       number(20,6)      ,/* 期初儲值金額 */
mmau008       number(20,6)      ,/* 期初儲值成本 */
mmau009       number(20,6)      ,/* 本次儲值金額 */
mmau010       number(20,6)      ,/* 儲值折扣率 */
mmau011       number(20,6)      ,/* 本次折扣金額 */
mmau012       number(20,6)      ,/* 本次加值金額 */
mmau013       number(20,6)      ,/* 本次送抵現值金額 */
mmau014       number(20,6)      ,/* 本次儲值成本 */
mmau015       number(20,6)      ,/* 期末儲值金額 */
mmau016       number(20,6)      ,/* 期末儲值成本 */
mmau017       number(20,6)      ,/* 單位儲值成本 */
mmau018       varchar2(10)      ,/* 異動營運據點 */
mmau019       varchar2(10)      ,/* 需求營運組織 */
mmauseq       number(10,0)      ,/* 異動序 */
mmau100       varchar2(40)      ,/* 請求GUID */
mmau101       varchar2(40)      /* 處理GUID */
);
alter table mmau_t add constraint mmau_pk primary key (mmauent,mmau001,mmau004,mmau005,mmauseq) enable validate;

create unique index mmau_pk on mmau_t (mmauent,mmau001,mmau004,mmau005,mmauseq);

grant select on mmau_t to tiptop;
grant update on mmau_t to tiptop;
grant delete on mmau_t to tiptop;
grant insert on mmau_t to tiptop;

exit;
