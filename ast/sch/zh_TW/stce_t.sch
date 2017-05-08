/* 
================================================================================
檔案代號:stce_t
檔案名稱:分銷合約主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stce_t
(
stceent       number(5)      ,/* 企業編號 */
stcesite       varchar2(10)      ,/* NO USE */
stceunit       varchar2(10)      ,/* 應用組織 */
stce001       varchar2(20)      ,/* 合約編號 */
stce002       varchar2(10)      ,/* 版本 */
stce003       varchar2(20)      ,/* 檔案編號 */
stce004       varchar2(10)      ,/* 模板編號 */
stce005       varchar2(10)      ,/* 經營方式 */
stce006       varchar2(10)      ,/* 結算方式 */
stce007       varchar2(10)      ,/* 結算類型 */
stce008       varchar2(10)      ,/* 對象類型 */
stce009       varchar2(10)      ,/* 經銷商編號 */
stce010       varchar2(10)      ,/* 網點編號 */
stce011       varchar2(10)      ,/* 客戶分類 */
stce012       varchar2(10)      ,/* 通路 */
stce013       date      ,/* 簽訂日期 */
stce014       varchar2(10)      ,/* 簽訂法人 */
stce015       varchar2(20)      ,/* 簽訂人員 */
stce016       varchar2(10)      ,/* 簽訂部門 */
stce017       date      ,/* 生效日期 */
stce018       date      ,/* 失效日期 */
stce019       date      ,/* 清退日期 */
stce020       date      ,/* 作廢日期 */
stce021       varchar2(10)      ,/* 幣別 */
stce022       varchar2(10)      ,/* 稅目 */
stce023       varchar2(10)      ,/* 收付款方式 */
stce024       varchar2(10)      ,/* 結算中心 */
stce025       varchar2(10)      ,/* 銷售組織 */
stce026       varchar2(10)      ,/* 結算地 */
stce027       varchar2(20)      ,/* 結算合約編號 */
stcestus       varchar2(10)      ,/* 狀態碼 */
stceownid       varchar2(20)      ,/* 資料所有者 */
stceowndp       varchar2(10)      ,/* 資料所屬部門 */
stcecrtid       varchar2(20)      ,/* 資料建立者 */
stcecrtdp       varchar2(10)      ,/* 資料建立部門 */
stcecrtdt       timestamp(0)      ,/* 資料創建日 */
stcemodid       varchar2(20)      ,/* 資料修改者 */
stcemoddt       timestamp(0)      ,/* 最近修改日 */
stcecnfid       varchar2(20)      ,/* 資料確認者 */
stcecnfdt       timestamp(0)      ,/* 資料確認日 */
stceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stceud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stce028       varchar2(10)      /* 銷售範圍 */
);
alter table stce_t add constraint stce_pk primary key (stceent,stce001) enable validate;

create unique index stce_pk on stce_t (stceent,stce001);

grant select on stce_t to tiptop;
grant update on stce_t to tiptop;
grant delete on stce_t to tiptop;
grant insert on stce_t to tiptop;

exit;
