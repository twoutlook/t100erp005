/* 
================================================================================
檔案代號:ecca_t
檔案名稱:料件製程變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ecca_t
(
eccaent       number(5)      ,/* 企業代碼 */
eccaownid       varchar2(20)      ,/* 資料所有者 */
eccaowndp       varchar2(10)      ,/* 資料所屬部門 */
eccacrtid       varchar2(20)      ,/* 資料建立者 */
eccacrtdp       varchar2(10)      ,/* 資料建立部門 */
eccacrtdt       timestamp(0)      ,/* 資料創建日 */
eccamodid       varchar2(20)      ,/* 資料修改者 */
eccamoddt       timestamp(0)      ,/* 最近修改日 */
eccacnfid       varchar2(20)      ,/* 資料確認者 */
eccacnfdt       timestamp(0)      ,/* 資料確認日 */
eccastus       varchar2(10)      ,/* 狀態碼 */
eccasite       varchar2(10)      ,/* 營運據點 */
eccadocno       varchar2(20)      ,/* 申請單號 */
eccadocdt       date      ,/* 申請日期 */
ecca001       varchar2(40)      ,/* 製程料號 */
ecca002       varchar2(10)      ,/* 製程編號 */
ecca003       varchar2(80)      ,/* 說明 */
ecca004       varchar2(1)      ,/* 申請類型 */
ecca900       number(10,0)      ,/* 變更序 */
ecca901       varchar2(1)      ,/* 變更類型 */
ecca902       date      ,/* 變更日期 */
ecca905       varchar2(10)      ,/* 變更理由 */
ecca906       varchar2(255)      ,/* 變更備註 */
eccaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
eccaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
eccaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
eccaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
eccaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
eccaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
eccaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
eccaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
eccaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
eccaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
eccaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
eccaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
eccaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
eccaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
eccaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
eccaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
eccaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
eccaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
eccaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
eccaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
eccaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
eccaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
eccaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
eccaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
eccaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
eccaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
eccaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
eccaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
eccaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
eccaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecca_t add constraint ecca_pk primary key (eccaent,eccasite,eccadocno) enable validate;

create unique index ecca_pk on ecca_t (eccaent,eccasite,eccadocno);

grant select on ecca_t to tiptop;
grant update on ecca_t to tiptop;
grant delete on ecca_t to tiptop;
grant insert on ecca_t to tiptop;

exit;
