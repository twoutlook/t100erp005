/* 
================================================================================
檔案代號:rtdo_t
檔案名稱:商品組成用量異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtdo_t
(
rtdoent       number(5)      ,/* 企業編號 */
rtdosite       varchar2(10)      ,/* 營運據點 */
rtdounit       varchar2(10)      ,/* 應用組織 */
rtdodocno       varchar2(20)      ,/* 申請單號 */
rtdodocdt       date      ,/* 申請日期 */
rtdo000       varchar2(10)      ,/* 申請類別 */
rtdo001       varchar2(40)      ,/* 主商品編號 */
rtdo002       varchar2(10)      ,/* 版本 */
rtdo003       varchar2(40)      ,/* 商品條碼 */
rtdo004       varchar2(10)      ,/* 單位 */
rtdoacti       varchar2(10)      ,/* 資料有效 */
rtdostus       varchar2(10)      ,/* 狀態碼 */
rtdoownid       varchar2(20)      ,/* 資料所有者 */
rtdoowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdocrtid       varchar2(20)      ,/* 資料建立者 */
rtdocrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdocrtdt       timestamp(0)      ,/* 資料創建日 */
rtdomodid       varchar2(20)      ,/* 資料修改者 */
rtdomoddt       timestamp(0)      ,/* 最近修改日 */
rtdocnfid       varchar2(20)      ,/* 資料確認者 */
rtdocnfdt       timestamp(0)      ,/* 資料確認日 */
rtdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdo_t add constraint rtdo_pk primary key (rtdoent,rtdodocno) enable validate;

create  index rtdo_n01 on rtdo_t (rtdo001);
create unique index rtdo_pk on rtdo_t (rtdoent,rtdodocno);

grant select on rtdo_t to tiptop;
grant update on rtdo_t to tiptop;
grant delete on rtdo_t to tiptop;
grant insert on rtdo_t to tiptop;

exit;
