/* 
================================================================================
檔案代號:gldf_t
檔案名稱:合併報表個體公司會計科目轉換資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldf_t
(
gldfent       number(5)      ,/* 企業編號 */
gldf001       varchar2(10)      ,/* 公司編號(轉換前) */
gldf002       varchar2(5)      ,/* 帳別/合併帳別(轉換前 */
gldf003       varchar2(10)      ,/* 公司編號(轉換後) */
gldf004       varchar2(5)      ,/* 合併帳別(轉換後) */
gldf005       varchar2(10)      ,/* 核算項資料 */
gldf006       varchar2(24)      ,/* 來源科目編號 */
gldf007       varchar2(24)      ,/* 合併科目編號 */
gldf008       varchar2(1)      ,/* 記帳幣換算類別 */
gldf009       varchar2(1)      ,/* 功能幣換算類別 */
gldf010       varchar2(1)      ,/* 報告幣換算類別 */
gldfstus       varchar2(1)      ,/* 狀態瑪 */
gldfownid       varchar2(20)      ,/* 資料所有者 */
gldfowndp       varchar2(10)      ,/* 資料所屬部門 */
gldfcrtid       varchar2(20)      ,/* 資料建立者 */
gldfcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldfcrtdt       timestamp(0)      ,/* 資料創建日 */
gldfmodid       varchar2(20)      ,/* 資料修改者 */
gldfmoddt       timestamp(0)      ,/* 最近修改日 */
gldfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldf_t add constraint gldf_pk primary key (gldfent,gldf001,gldf002,gldf003,gldf004,gldf005,gldf006) enable validate;

create unique index gldf_pk on gldf_t (gldfent,gldf001,gldf002,gldf003,gldf004,gldf005,gldf006);

grant select on gldf_t to tiptop;
grant update on gldf_t to tiptop;
grant delete on gldf_t to tiptop;
grant insert on gldf_t to tiptop;

exit;
