/* 
================================================================================
檔案代號:inay_t
檔案名稱:集團庫位基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inay_t
(
inayent       number(5)      ,/* 企業代碼 */
inay001       varchar2(10)      ,/* 庫位編號 */
inayownid       varchar2(20)      ,/* 資料所有者 */
inayowndp       varchar2(10)      ,/* 資料所屬部門 */
inaycrtid       varchar2(20)      ,/* 資料建立者 */
inaycrtdp       varchar2(10)      ,/* 資料建立部門 */
inaycrtdt       timestamp(0)      ,/* 資料創建日 */
inaymodid       varchar2(20)      ,/* 資料修改者 */
inaymoddt       timestamp(0)      ,/* 最近修改日 */
inaystus       varchar2(10)      ,/* 狀態碼 */
inayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inay_t add constraint inay_pk primary key (inayent,inay001) enable validate;

create unique index inay_pk on inay_t (inayent,inay001);

grant select on inay_t to tiptop;
grant update on inay_t to tiptop;
grant delete on inay_t to tiptop;
grant insert on inay_t to tiptop;

exit;
