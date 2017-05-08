/* 
================================================================================
檔案代號:stib_t
檔案名稱:意向協議單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stib_t
(
stibent       number(5)      ,/* 企業編號 */
stibsite       varchar2(10)      ,/* 營運據點 */
stibunit       varchar2(10)      ,/* 應用組織 */
stibdocno       varchar2(20)      ,/* 單據編號 */
stibseq       number(10,0)      ,/* 單據項次 */
stib001       varchar2(20)      ,/* 場地編號 */
stib002       number(5,0)      ,/* 場地版本 */
stib003       varchar2(10)      ,/* 樓棟編號 */
stib004       varchar2(10)      ,/* 樓層編號 */
stib005       varchar2(10)      ,/* 區域編號 */
stib006       number(20,6)      ,/* 建築面積 */
stib007       number(20,6)      ,/* 測量面積 */
stib008       number(20,6)      ,/* 經營面積 */
stib009       varchar2(10)      ,/* 場地使用狀態 */
stibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stibud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stib_t add constraint stib_pk primary key (stibent,stibdocno,stibseq) enable validate;

create unique index stib_pk on stib_t (stibent,stibdocno,stibseq);

grant select on stib_t to tiptop;
grant update on stib_t to tiptop;
grant delete on stib_t to tiptop;
grant insert on stib_t to tiptop;

exit;
