/* 
================================================================================
檔案代號:xcbb_t
檔案名稱:料件據點成本資料按期設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbb_t
(
xcbbent       number(5)      ,/* 企業代碼 */
xcbbownid       varchar2(20)      ,/* 資料所有者 */
xcbbowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbbcrtid       varchar2(20)      ,/* 資料建立者 */
xcbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbbcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbbmodid       varchar2(20)      ,/* 資料修改者 */
xcbbmoddt       timestamp(0)      ,/* 最近修改日 */
xcbbstus       varchar2(10)      ,/* 狀態碼 */
xcbbcomp       varchar2(10)      ,/* 法人組織 */
xcbb001       number(5,0)      ,/* 年度 */
xcbb002       number(5,0)      ,/* 期別 */
xcbb003       varchar2(40)      ,/* 料號 */
xcbb004       varchar2(256)      ,/* 特性 */
xcbb005       varchar2(10)      ,/* 成本單位 */
xcbb006       number(5,0)      ,/* 成本階 */
xcbb007       number(15,3)      ,/* 按發料計算的低階碼 */
xcbb008       number(15,3)      ,/* 按BOM計算的低階碼 */
xcbb009       varchar2(1)      ,/* 當月入聯產品否 */
xcbb010       varchar2(10)      ,/* 成本分群 */
xcbb011       varchar2(10)      ,/* no use */
xcbb012       varchar2(10)      ,/* 主分群碼 */
xcbb013       varchar2(10)      ,/* no use */
xcbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbb_t add constraint xcbb_pk primary key (xcbbent,xcbbcomp,xcbb001,xcbb002,xcbb003,xcbb004) enable validate;

create unique index xcbb_pk on xcbb_t (xcbbent,xcbbcomp,xcbb001,xcbb002,xcbb003,xcbb004);

grant select on xcbb_t to tiptop;
grant update on xcbb_t to tiptop;
grant delete on xcbb_t to tiptop;
grant insert on xcbb_t to tiptop;

exit;
