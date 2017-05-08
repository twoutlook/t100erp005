/* 
================================================================================
檔案代號:pmag_t
檔案名稱:供應商證照檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmag_t
(
pmagstus       varchar2(1)      ,/* 狀態碼 */
pmagent       number(5)      ,/* 企業編號 */
pmag001       varchar2(10)      ,/* 供應商編號 */
pmag002       varchar2(10)      ,/* 證照類別 */
pmag003       varchar2(40)      ,/* 證照編號 */
pmag004       varchar2(255)      ,/* 證照名稱 */
pmag005       varchar2(10)      ,/* 經營品類 */
pmag006       varchar2(40)      ,/* 商品編號 */
pmag007       date      ,/* 生效日期 */
pmag008       date      ,/* 失效日期 */
pmag009       varchar2(10)      ,/* 證照提供組織 */
pmagownid       varchar2(20)      ,/* 資料所有者 */
pmagowndp       varchar2(10)      ,/* 資料所屬部門 */
pmagcrtid       varchar2(20)      ,/* 資料建立者 */
pmagcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmagcrtdt       timestamp(0)      ,/* 資料創建日 */
pmagmodid       varchar2(20)      ,/* 資料修改者 */
pmagmoddt       timestamp(0)      ,/* 最近修改日 */
pmagcnfid       varchar2(20)      ,/* 資料確認者 */
pmagcnfdt       timestamp(0)      ,/* 資料確認日 */
pmagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmag_t add constraint pmag_pk primary key (pmagent,pmag001,pmag002,pmag003) enable validate;

create unique index pmag_pk on pmag_t (pmagent,pmag001,pmag002,pmag003);

grant select on pmag_t to tiptop;
grant update on pmag_t to tiptop;
grant delete on pmag_t to tiptop;
grant insert on pmag_t to tiptop;

exit;
