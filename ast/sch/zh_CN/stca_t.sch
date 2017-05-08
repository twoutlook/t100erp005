/* 
================================================================================
檔案代號:stca_t
檔案名稱:分銷合約申請資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stca_t
(
stcaent       number(5)      ,/* 企業編號 */
stcasite       varchar2(10)      ,/* 營運據點 */
stcaunit       varchar2(10)      ,/* 應用組織 */
stcadocdt       date      ,/* 單據日期 */
stcadocno       varchar2(20)      ,/* 單據編號 */
stca000       varchar2(10)      ,/* 申請類型 */
stca001       varchar2(20)      ,/* 合約編號 */
stca002       varchar2(10)      ,/* 版本 */
stca003       varchar2(20)      ,/* 文件編號 */
stca004       varchar2(10)      ,/* 模板編號 */
stca005       varchar2(10)      ,/* 經營方式 */
stca006       varchar2(10)      ,/* 結算方式 */
stca007       varchar2(10)      ,/* 結算類型 */
stca008       varchar2(10)      ,/* 對象類型 */
stca009       varchar2(10)      ,/* 經銷商編號 */
stca010       varchar2(10)      ,/* 網點編號 */
stca011       varchar2(10)      ,/* 客戶分類 */
stca012       varchar2(10)      ,/* 渠道 */
stca013       date      ,/* 簽訂日期 */
stca014       varchar2(10)      ,/* 簽訂法人 */
stca015       varchar2(20)      ,/* 簽訂人員 */
stca016       varchar2(10)      ,/* 簽訂部門 */
stca017       date      ,/* 生效日期 */
stca018       date      ,/* 失效日期 */
stca019       date      ,/* 清退日期 */
stca020       date      ,/* 作廢日期 */
stca021       varchar2(10)      ,/* 幣別 */
stca022       varchar2(10)      ,/* 稅目 */
stca023       varchar2(10)      ,/* 收付款方式 */
stca024       varchar2(10)      ,/* 結算中心 */
stca025       varchar2(10)      ,/* 銷售組織 */
stca026       varchar2(10)      ,/* 結算地 */
stca027       varchar2(20)      ,/* 結算合約編號 */
stcaacti       varchar2(1)      ,/* 資料有效否 */
stcastus       varchar2(10)      ,/* 狀態碼 */
stcaownid       varchar2(20)      ,/* 資料所有者 */
stcaowndp       varchar2(10)      ,/* 資料所屬部門 */
stcacrtid       varchar2(20)      ,/* 資料建立者 */
stcacrtdp       varchar2(10)      ,/* 資料建立部門 */
stcacrtdt       timestamp(0)      ,/* 資料創建日 */
stcamodid       varchar2(20)      ,/* 資料修改者 */
stcamoddt       timestamp(0)      ,/* 最近修改日 */
stcacnfid       varchar2(20)      ,/* 資料確認者 */
stcacnfdt       timestamp(0)      ,/* 資料確認日 */
stcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stca028       varchar2(10)      /* 銷售範圍 */
);
alter table stca_t add constraint stca_pk primary key (stcaent,stcadocno) enable validate;

create unique index stca_pk on stca_t (stcaent,stcadocno);

grant select on stca_t to tiptop;
grant update on stca_t to tiptop;
grant delete on stca_t to tiptop;
grant insert on stca_t to tiptop;

exit;
