/* 
================================================================================
檔案代號:mmeb_t
檔案名稱:會員卡補卡資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmeb_t
(
mmebent       number(5)      ,/* 企業編號 */
mmebsite       varchar2(10)      ,/* 營運據點 */
mmebunit       varchar2(10)      ,/* 應用組織 */
mmebdocno       varchar2(20)      ,/* 單據編號 */
mmebseq       number(10,0)      ,/* 項次 */
mmeb001       varchar2(30)      ,/* 原卡卡號 */
mmeb002       varchar2(10)      ,/* 原卡卡種編號 */
mmeb003       varchar2(30)      ,/* 會員編號 */
mmeb004       date      ,/* 原卡效期 */
mmeb005       number(15,3)      ,/* 原卡內積點 */
mmeb006       number(20,6)      ,/* 原卡內儲值餘額 */
mmeb007       number(20,6)      ,/* 原卡內儲值成本 */
mmeb008       varchar2(30)      ,/* 新卡卡號 */
mmeb009       varchar2(10)      ,/* 新卡卡種編號 */
mmeb010       varchar2(10)      ,/* 新卡可儲值 */
mmeb011       number(20,6)      ,/* 新卡儲值折扣率 */
mmeb012       number(20,6)      ,/* 補卡工本費 */
mmeb013       varchar2(10)      ,/* 庫區 */
mmeb014       varchar2(10)      ,/* 理由碼 */
mmeb015       varchar2(1)      ,/* 原卡狀態 */
mmebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmeb_t add constraint mmeb_pk primary key (mmebent,mmebdocno,mmebseq) enable validate;

create unique index mmeb_pk on mmeb_t (mmebent,mmebdocno,mmebseq);

grant select on mmeb_t to tiptop;
grant update on mmeb_t to tiptop;
grant delete on mmeb_t to tiptop;
grant insert on mmeb_t to tiptop;

exit;
