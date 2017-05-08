/* 
================================================================================
檔案代號:crcc_t
檔案名稱:客戶調查問卷問題明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table crcc_t
(
crccent       number(5)      ,/* 企業編號 */
crccstus       varchar2(1)      ,/* 狀態 */
crcc001       varchar2(10)      ,/* 調查問卷編號 */
crcc002       varchar2(10)      ,/* 問題編號 */
crcc003       varchar2(500)      ,/* 問題內容 */
crcc004       number(15,3)      ,/* 分數 */
crcc005       varchar2(1)      ,/* 答案類型 */
crcc006       varchar2(1)      ,/* 計算類型 */
crccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crcc_t add constraint crcc_pk primary key (crccent,crcc001,crcc002) enable validate;

create unique index crcc_pk on crcc_t (crccent,crcc001,crcc002);

grant select on crcc_t to tiptop;
grant update on crcc_t to tiptop;
grant delete on crcc_t to tiptop;
grant insert on crcc_t to tiptop;

exit;
