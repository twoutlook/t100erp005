/* 
================================================================================
檔案代號:mmec_t
檔案名稱:會員卡換卡資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmec_t
(
mmecent       number(5)      ,/* 企業編號 */
mmecsite       varchar2(10)      ,/* 營運據點 */
mmecunit       varchar2(10)      ,/* 應用組織 */
mmecdocno       varchar2(20)      ,/* 單據編號 */
mmecseq       number(10,0)      ,/* 項次 */
mmec001       varchar2(30)      ,/* 原卡卡號 */
mmec002       varchar2(10)      ,/* 原卡卡種編號 */
mmec003       varchar2(30)      ,/* 會員編號 */
mmec004       date      ,/* 原卡效期 */
mmec005       number(15,3)      ,/* 原卡內積點 */
mmec006       number(20,6)      ,/* 原卡內儲值餘額 */
mmec007       number(20,6)      ,/* 原卡內儲值成本 */
mmec008       varchar2(30)      ,/* 新卡卡號 */
mmec009       varchar2(10)      ,/* 新卡卡種編號 */
mmec010       varchar2(10)      ,/* 新卡可儲值 */
mmec011       number(20,6)      ,/* 新卡儲值折扣率 */
mmec012       number(20,6)      ,/* 換卡工本費 */
mmec013       varchar2(10)      ,/* 庫區 */
mmec014       varchar2(10)      ,/* 理由碼 */
mmec015       varchar2(1)      ,/* 原卡狀態 */
mmecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmec_t add constraint mmec_pk primary key (mmecent,mmecdocno,mmecseq) enable validate;

create unique index mmec_pk on mmec_t (mmecent,mmecdocno,mmecseq);

grant select on mmec_t to tiptop;
grant update on mmec_t to tiptop;
grant delete on mmec_t to tiptop;
grant insert on mmec_t to tiptop;

exit;
