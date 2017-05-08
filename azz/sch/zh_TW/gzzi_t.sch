/* 
================================================================================
檔案代號:gzzi_t
檔案名稱:安全機製作業紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzzi_t
(
gzziownid       varchar2(20)      ,/* 資料所有者 */
gzziowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzicrtid       varchar2(20)      ,/* 資料建立者 */
gzzicrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzicrtdt       timestamp(0)      ,/* 資料創建日 */
gzzimodid       varchar2(20)      ,/* 資料修改者 */
gzzimoddt       timestamp(0)      ,/* 最近修改日 */
gzzistus       varchar2(10)      ,/* 狀態碼 */
gzzi001       varchar2(20)      ,/* 程式編號 */
gzzi002       varchar2(4)      ,/* 歸屬模組 */
gzziud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzziud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzziud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzziud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzziud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzziud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzziud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzziud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzziud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzziud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzziud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzziud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzziud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzziud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzziud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzziud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzziud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzziud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzziud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzziud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzziud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzziud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzziud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzziud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzziud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzziud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzziud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzziud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzziud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzziud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzzi003       varchar2(80)      ,/* MD5 */
gzzi004       blob      /* 42m */
);
alter table gzzi_t add constraint gzzi_pk primary key (gzzi001,gzzi002) enable validate;

create unique index gzzi_pk on gzzi_t (gzzi001,gzzi002);

grant select on gzzi_t to tiptop;
grant update on gzzi_t to tiptop;
grant delete on gzzi_t to tiptop;
grant insert on gzzi_t to tiptop;

exit;
