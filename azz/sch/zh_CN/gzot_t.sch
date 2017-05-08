/* 
================================================================================
檔案代號:gzot_t
檔案名稱:時區資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzot_t
(
gzotstus       varchar2(10)      ,/* 狀態碼 */
gzot001       varchar2(10)      ,/* 時區編號 */
gzot002       varchar2(10)      ,/* 時區簡碼 */
gzot003       varchar2(255)      ,/* 代表城市 */
gzotownid       varchar2(20)      ,/* 資料所有者 */
gzotowndp       varchar2(10)      ,/* 資料所屬部門 */
gzotcrtid       varchar2(20)      ,/* 資料建立者 */
gzotcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzotcrtdt       timestamp(0)      ,/* 資料創建日 */
gzotmodid       varchar2(20)      ,/* 資料修改者 */
gzotmoddt       timestamp(0)      ,/* 最近修改日 */
gzotud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzotud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzotud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzotud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzotud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzotud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzotud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzotud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzotud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzotud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzotud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzotud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzotud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzotud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzotud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzotud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzotud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzotud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzotud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzotud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzotud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzotud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzotud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzotud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzotud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzotud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzotud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzotud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzotud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzotud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzot_t add constraint gzot_pk primary key (gzot001) enable validate;

create unique index gzot_pk on gzot_t (gzot001);

grant select on gzot_t to tiptop;
grant update on gzot_t to tiptop;
grant delete on gzot_t to tiptop;
grant insert on gzot_t to tiptop;

exit;
