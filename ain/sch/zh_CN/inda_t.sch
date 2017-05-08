/* 
================================================================================
檔案代號:inda_t
檔案名稱:調撥申請單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inda_t
(
indaent       number(5)      ,/* 企業編號 */
indasite       varchar2(10)      ,/* 營運據點 */
indaunit       varchar2(10)      ,/* 應用組織 */
indadocno       varchar2(20)      ,/* 單號 */
indadocdt       date      ,/* 單據日期 */
inda001       varchar2(20)      ,/* 申請人員 */
inda002       varchar2(10)      ,/* 上級組織 */
inda003       varchar2(10)      ,/* 撥出組織 */
inda004       varchar2(10)      ,/* 撥入組織 */
inda005       date      ,/* 調撥日期 */
inda006       varchar2(255)      ,/* 備註 */
indaownid       varchar2(20)      ,/* 資料所有者 */
indaowndp       varchar2(10)      ,/* 資料所屬部門 */
indacrtid       varchar2(20)      ,/* 資料建立者 */
indacrtdp       varchar2(10)      ,/* 資料建立部門 */
indacrtdt       timestamp(0)      ,/* 資料創建日 */
indamodid       varchar2(20)      ,/* 資料修改者 */
indamoddt       timestamp(0)      ,/* 最近修改日 */
indacnfid       varchar2(20)      ,/* 資料確認者 */
indacnfdt       timestamp(0)      ,/* 資料確認日 */
indastus       varchar2(10)      ,/* 狀態碼 */
inda101       varchar2(10)      ,/* 申請部門 */
inda102       varchar2(10)      ,/* 檢驗方式 */
inda103       varchar2(10)      ,/* 包裝單製作 */
inda104       varchar2(1)      ,/* Invoice製作 */
inda105       varchar2(10)      ,/* 送貨地址代碼 */
inda106       varchar2(10)      ,/* 運輸方式 */
inda107       varchar2(10)      ,/* 交運地點 */
inda108       varchar2(10)      ,/* 交運終點 */
inda109       varchar2(10)      ,/* 調撥方式 */
inda151       varchar2(10)      ,/* 理由碼 */
indaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inda007       varchar2(1)      /* 單一單位庫存單位變更 */
);
alter table inda_t add constraint inda_pk primary key (indaent,indadocno) enable validate;

create unique index inda_pk on inda_t (indaent,indadocno);

grant select on inda_t to tiptop;
grant update on inda_t to tiptop;
grant delete on inda_t to tiptop;
grant insert on inda_t to tiptop;

exit;
