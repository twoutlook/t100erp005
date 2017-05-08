/* 
================================================================================
檔案代號:pcbb_t
檔案名稱:觸屏方案基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcbb_t
(
pcbbent       number(5)      ,/* 企業編號 */
pcbbunit       varchar2(10)      ,/* 應用組織 */
pcbb001       varchar2(10)      ,/* 方案編號 */
pcbb002       varchar2(10)      ,/* 分類來源 */
pcbb003       number(5,0)      ,/* 傳POS狀態 */
pcbb004       number(5,0)      ,/* 大類列數 */
pcbb005       number(5,0)      ,/* 大類行數 */
pcbb006       number(5,0)      ,/* 小類列數 */
pcbb007       number(5,0)      ,/* 小類行數 */
pcbb008       number(5,0)      ,/* 產品列數 */
pcbb009       number(5,0)      ,/* 產品行數 */
pcbbstus       varchar2(10)      ,/* 狀態碼 */
pcbbownid       varchar2(20)      ,/* 資料所有者 */
pcbbowndp       varchar2(10)      ,/* 資料所屬部門 */
pcbbcrtid       varchar2(20)      ,/* 資料建立者 */
pcbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcbbcrtdt       timestamp(0)      ,/* 資料創建日 */
pcbbmodid       varchar2(20)      ,/* 資料修改者 */
pcbbmoddt       timestamp(0)      ,/* 最近修改日 */
pcbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcbb_t add constraint pcbb_pk primary key (pcbbent,pcbb001) enable validate;

create unique index pcbb_pk on pcbb_t (pcbbent,pcbb001);

grant select on pcbb_t to tiptop;
grant update on pcbb_t to tiptop;
grant delete on pcbb_t to tiptop;
grant insert on pcbb_t to tiptop;

exit;
