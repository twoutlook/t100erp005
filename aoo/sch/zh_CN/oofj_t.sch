/* 
================================================================================
檔案代號:oofj_t
檔案名稱:編碼轉換單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofj_t
(
oofjent       number(5)      ,/* 企業編號 */
oofjownid       varchar2(20)      ,/* 資料所有者 */
oofjowndp       varchar2(10)      ,/* 資料所屬部門 */
oofjcrtid       varchar2(20)      ,/* 資料建立者 */
oofjcrtdp       varchar2(10)      ,/* 資料建立部門 */
oofjcrtdt       timestamp(0)      ,/* 資料創建日 */
oofjmodid       varchar2(20)      ,/* 資料修改者 */
oofjmoddt       timestamp(0)      ,/* 最近修改日 */
oofjstus       varchar2(10)      ,/* 狀態碼 */
oofj001       varchar2(10)      ,/* 轉換表號 */
oofjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofj_t add constraint oofj_pk primary key (oofjent,oofj001) enable validate;

create unique index oofj_pk on oofj_t (oofjent,oofj001);

grant select on oofj_t to tiptop;
grant update on oofj_t to tiptop;
grant delete on oofj_t to tiptop;
grant insert on oofj_t to tiptop;

exit;
