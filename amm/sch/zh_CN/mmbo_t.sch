/* 
================================================================================
檔案代號:mmbo_t
檔案名稱:卡活動規則申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbo_t
(
mmboent       number(5)      ,/* 企業編號 */
mmbosite       varchar2(10)      ,/* 營運據點 */
mmbounit       varchar2(10)      ,/* 應用組織 */
mmbodocno       varchar2(20)      ,/* 單據編號 */
mmbodocdt       date      ,/* 單據日期 */
mmbo000       varchar2(10)      ,/* 異動類型 */
mmbo001       varchar2(30)      ,/* 活動規則編號 */
mmbo002       varchar2(10)      ,/* 版本 */
mmbo003       varchar2(80)      ,/* 活動規則說明 */
mmbo004       varchar2(10)      ,/* 活動類型 */
mmbo005       varchar2(10)      ,/* 規則對象編號 */
mmbo006       varchar2(30)      ,/* 活動檔期編號 */
mmbo007       varchar2(10)      ,/* 規則類型 */
mmbo008       varchar2(10)      ,/* 排除方式 */
mmbo009       varchar2(10)      ,/* 累計方式 */
mmbo010       varchar2(10)      ,/* 換贈方式 */
mmbo011       varchar2(10)      ,/* 規則兌換限制 */
mmbo012       number(5,0)      ,/* 規則兌換次數 */
mmbo013       varchar2(1)      ,/* 參加其他換贈 */
mmbo014       date      ,/* 開始日期 */
mmbo015       date      ,/* 結束日期 */
mmboacti       varchar2(1)      ,/* 資料有效 */
mmboownid       varchar2(20)      ,/* 資料所有者 */
mmboowndp       varchar2(10)      ,/* 資料所有部門 */
mmbocrtid       varchar2(20)      ,/* 資料建立者 */
mmbocrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbocrtdt       timestamp(0)      ,/* 資料創建日 */
mmbomodid       varchar2(20)      ,/* 資料修改者 */
mmbomoddt       timestamp(0)      ,/* 最近修改日 */
mmbocnfid       varchar2(20)      ,/* 資料確認者 */
mmbocnfdt       timestamp(0)      ,/* 資料確認日 */
mmbostus       varchar2(10)      ,/* 狀態碼 */
mmboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmboud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmbo016       varchar2(1)      ,/* 限定金額 */
mmbo017       varchar2(1)      ,/* 規則對象 */
mmbo018       varchar2(20)      /* no use */
);
alter table mmbo_t add constraint mmbo_pk primary key (mmboent,mmbodocno) enable validate;

create unique index mmbo_pk on mmbo_t (mmboent,mmbodocno);

grant select on mmbo_t to tiptop;
grant update on mmbo_t to tiptop;
grant delete on mmbo_t to tiptop;
grant insert on mmbo_t to tiptop;

exit;
