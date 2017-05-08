/* 
================================================================================
檔案代號:xrah_t
檔案名稱:帳務組織結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrah_t
(
xrahent       number(5)      ,/* 企業編號 */
xrahownid       varchar2(20)      ,/* 資料所有者 */
xrahowndp       varchar2(10)      ,/* 資料所屬部門 */
xrahcrtid       varchar2(20)      ,/* 資料建立者 */
xrahcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrahcrtdt       timestamp(0)      ,/* 資料創建日 */
xrahmodid       varchar2(20)      ,/* 資料修改者 */
xrahmoddt       timestamp(0)      ,/* 最近修改日 */
xrahstus       varchar2(10)      ,/* 狀態碼 */
xrah001       varchar2(1)      ,/* 組織類型 */
xrah002       varchar2(10)      ,/* 帳務中心 */
xrah003       number(5,0)      ,/* 版本 */
xrah004       varchar2(10)      ,/* 組織編號 */
xrah005       varchar2(10)      ,/* 上層組織編號 */
xrah006       date      ,/* 生效日期 */
xrah007       varchar2(1)      ,/* 執行版本否 */
xrahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrah_t add constraint xrah_pk primary key (xrahent,xrah001,xrah002,xrah003,xrah004) enable validate;

create unique index xrah_pk on xrah_t (xrahent,xrah001,xrah002,xrah003,xrah004);

grant select on xrah_t to tiptop;
grant update on xrah_t to tiptop;
grant delete on xrah_t to tiptop;
grant insert on xrah_t to tiptop;

exit;
