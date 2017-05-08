/* 
================================================================================
檔案代號:oocs_t
檔案名稱:國際標準單位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocs_t
(
oocsent       number(5)      ,/* 企業編號 */
oocs001       varchar2(10)      ,/* ISO單位代碼 */
oocs002       varchar2(10)      ,/* 單位類型 */
oocs003       varchar2(10)      ,/* 面積單位代碼 */
oocs004       varchar2(10)      ,/* 體積單位代碼 */
oocsownid       varchar2(20)      ,/* 資料所有者 */
oocsowndp       varchar2(10)      ,/* 資料所屬部門 */
oocscrtid       varchar2(20)      ,/* 資料建立者 */
oocscrtdp       varchar2(10)      ,/* 資料建立部門 */
oocscrtdt       timestamp(0)      ,/* 資料創建日 */
oocsmodid       varchar2(20)      ,/* 資料修改者 */
oocsmoddt       timestamp(0)      ,/* 最近修改日 */
oocsstus       varchar2(10)      ,/* 狀態碼 */
oocsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocs_t add constraint oocs_pk primary key (oocsent,oocs001) enable validate;

create unique index oocs_pk on oocs_t (oocsent,oocs001);

grant select on oocs_t to tiptop;
grant update on oocs_t to tiptop;
grant delete on oocs_t to tiptop;
grant insert on oocs_t to tiptop;

exit;
