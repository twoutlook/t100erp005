/* 
================================================================================
檔案代號:mmco_t
檔案名稱:卡折扣一般規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmco_t
(
mmcoent       number(5)      ,/* 企業編號 */
mmcosite       varchar2(10)      ,/* 營運據點 */
mmcounit       varchar2(10)      ,/* 應用組織 */
mmcodocno       varchar2(30)      ,/* 單據編號 */
mmco001       varchar2(30)      ,/* 活動規則編號 */
mmco002       varchar2(10)      ,/* 卡種編號 */
mmco003       varchar2(10)      ,/* 規則類型 */
mmco004       varchar2(40)      ,/* 規則編碼 */
mmco005       number(20,6)      ,/* 折扣率 */
mmcoacti       varchar2(1)      ,/* 資料有效 */
mmcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmco_t add constraint mmco_pk primary key (mmcoent,mmcodocno,mmco003,mmco004) enable validate;

create unique index mmco_pk on mmco_t (mmcoent,mmcodocno,mmco003,mmco004);

grant select on mmco_t to tiptop;
grant update on mmco_t to tiptop;
grant delete on mmco_t to tiptop;
grant insert on mmco_t to tiptop;

exit;
