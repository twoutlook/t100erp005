/* 
================================================================================
檔案代號:xcbc_t
檔案名稱:成本分群成本階範圍設定檔案
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbc_t
(
xcbcent       number(5)      ,/* 企業編號 */
xcbcownid       varchar2(20)      ,/* 資料所有者 */
xcbcowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbccrtid       varchar2(20)      ,/* 資料建立者 */
xcbccrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbccrtdt       timestamp(0)      ,/* 資料創建日 */
xcbcmodid       varchar2(20)      ,/* 資料修改者 */
xcbcmoddt       timestamp(0)      ,/* 最近修改日 */
xcbcstus       varchar2(10)      ,/* 狀態碼 */
xcbc001       varchar2(10)      ,/* 法人組織 */
xcbc002       varchar2(10)      ,/* 成本分群碼 */
xcbc003       number(5,0)      ,/* 起始成本階 */
xcbc004       number(5,0)      ,/* 截止成本階 */
xcbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbc_t add constraint xcbc_pk primary key (xcbcent,xcbc001,xcbc002) enable validate;

create unique index xcbc_pk on xcbc_t (xcbcent,xcbc001,xcbc002);

grant select on xcbc_t to tiptop;
grant update on xcbc_t to tiptop;
grant delete on xcbc_t to tiptop;
grant insert on xcbc_t to tiptop;

exit;
