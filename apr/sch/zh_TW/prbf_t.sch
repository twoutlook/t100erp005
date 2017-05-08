/* 
================================================================================
檔案代號:prbf_t
檔案名稱:標準調價單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbf_t
(
prbfent       number(5)      ,/* 企業編號 */
prbfunit       varchar2(10)      ,/* 應用組織 */
prbfsite       varchar2(10)      ,/* 營運據點 */
prbfdocno       varchar2(20)      ,/* 單據編號 */
prbfdocdt       date      ,/* 單據日期 */
prbf001       varchar2(10)      ,/* 單據類型 */
prbf002       varchar2(10)      ,/* 資料來源 */
prbf003       varchar2(20)      ,/* 來源單號 */
prbf004       varchar2(10)      ,/* 供應商編號 */
prbf005       varchar2(10)      ,/* 管理品類 */
prbf006       date      ,/* 開始日期 */
prbf007       date      ,/* 結束日期 */
prbf008       varchar2(8)      ,/* no use */
prbf009       varchar2(8)      ,/* no use */
prbf010       varchar2(20)      ,/* 人員 */
prbf011       varchar2(10)      ,/* 部門 */
prbf012       varchar2(255)      ,/* 備註 */
prbfownid       varchar2(20)      ,/* 資料所有者 */
prbfowndp       varchar2(10)      ,/* 資料所屬部門 */
prbfcrtid       varchar2(20)      ,/* 資料建立者 */
prbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
prbfcrtdt       timestamp(0)      ,/* 資料創建日 */
prbfmodid       varchar2(20)      ,/* 資料修改者 */
prbfmoddt       timestamp(0)      ,/* 最近修改日 */
prbfcnfid       varchar2(20)      ,/* 資料確認者 */
prbfcnfdt       timestamp(0)      ,/* 資料確認日 */
prbfstus       varchar2(10)      ,/* 狀態碼 */
prbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbfud002       varchar2(40)      ,/* 購銷是否對新進價低於原進價的商品調整現有庫存 */
prbfud003       varchar2(40)      ,/* 庫存調整單號 */
prbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbf013       varchar2(40)      /* 活動類型 */
);
alter table prbf_t add constraint prbf_pk primary key (prbfent,prbfdocno) enable validate;

create unique index prbf_pk on prbf_t (prbfent,prbfdocno);

grant select on prbf_t to tiptop;
grant update on prbf_t to tiptop;
grant delete on prbf_t to tiptop;
grant insert on prbf_t to tiptop;

exit;
