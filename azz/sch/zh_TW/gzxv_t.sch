/* 
================================================================================
檔案代號:gzxv_t
檔案名稱:使用者在不同營運據點對應作業檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxv_t
(
gzxvstus       varchar2(10)      ,/* 狀態碼 */
gzxvent       number(5)      ,/* 企業編號 */
gzxv001       varchar2(20)      ,/* 員工編號 */
gzxv002       varchar2(20)      ,/* 程式編號 */
gzxv003       varchar2(10)      ,/* 營運據點編號 */
gzxv004       date      ,/* 生效日期 */
gzxv005       date      ,/* 失效日期 */
gzxvownid       varchar2(20)      ,/* 資料所有者 */
gzxvowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxvcrtid       varchar2(20)      ,/* 資料建立者 */
gzxvcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxvcrtdt       timestamp(0)      ,/* 資料創建日 */
gzxvmodid       varchar2(20)      ,/* 資料修改者 */
gzxvmoddt       timestamp(0)      ,/* 最近修改日 */
gzxvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxv_t add constraint gzxv_pk primary key (gzxvent,gzxv001,gzxv002,gzxv003) enable validate;

create unique index gzxv_pk on gzxv_t (gzxvent,gzxv001,gzxv002,gzxv003);

grant select on gzxv_t to tiptop;
grant update on gzxv_t to tiptop;
grant delete on gzxv_t to tiptop;
grant insert on gzxv_t to tiptop;

exit;
