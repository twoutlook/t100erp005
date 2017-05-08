/* 
================================================================================
檔案代號:xcbo_t
檔案名稱:聯產品預設分配比例設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbo_t
(
xcboent       number(5)      ,/* 企業編號 */
xcbosite       varchar2(10)      ,/* 營運據點 */
xcbo001       varchar2(40)      ,/* 主件料號 */
xcbo002       varchar2(40)      ,/* 聯產品料號 */
xcbo003       varchar2(10)      ,/* 聯產品單位 */
xcbo004       number(20,6)      ,/* 分配率 */
xcboownid       varchar2(20)      ,/* 資料所有者 */
xcboowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbocrtid       varchar2(20)      ,/* 資料建立者 */
xcbocrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbocrtdt       timestamp(0)      ,/* 資料創建日 */
xcbomodid       varchar2(20)      ,/* 資料修改者 */
xcbomoddt       timestamp(0)      ,/* 最近修改日 */
xcbostus       varchar2(10)      ,/* 狀態碼 */
xcboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbo_t add constraint xcbo_pk primary key (xcboent,xcbosite,xcbo001,xcbo002) enable validate;

create unique index xcbo_pk on xcbo_t (xcboent,xcbosite,xcbo001,xcbo002);

grant select on xcbo_t to tiptop;
grant update on xcbo_t to tiptop;
grant delete on xcbo_t to tiptop;
grant insert on xcbo_t to tiptop;

exit;
