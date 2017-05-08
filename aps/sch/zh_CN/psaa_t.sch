/* 
================================================================================
檔案代號:psaa_t
檔案名稱:獨立需求單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table psaa_t
(
psaaent       number(5)      ,/* 企業編號 */
psaasite       varchar2(10)      ,/* 營運據點 */
psaadocno       varchar2(20)      ,/* 需求單號 */
psaadocdt       date      ,/* 單據日期 */
psaa001       varchar2(20)      ,/* 申請人員 */
psaa002       varchar2(10)      ,/* 部門 */
psaa003       varchar2(255)      ,/* 備註 */
psaaownid       varchar2(20)      ,/* 資料所有者 */
psaaowndp       varchar2(10)      ,/* 資料所屬部門 */
psaacrtid       varchar2(20)      ,/* 資料建立者 */
psaacrtdp       varchar2(10)      ,/* 資料建立部門 */
psaacrtdt       timestamp(0)      ,/* 資料創建日 */
psaamodid       varchar2(20)      ,/* 資料修改者 */
psaamoddt       timestamp(0)      ,/* 最近修改日 */
psaacnfid       varchar2(20)      ,/* 資料確認者 */
psaacnfdt       timestamp(0)      ,/* 資料確認日 */
psaastus       varchar2(10)      ,/* 狀態碼 */
psaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psaa_t add constraint psaa_pk primary key (psaaent,psaadocno) enable validate;

create unique index psaa_pk on psaa_t (psaaent,psaadocno);

grant select on psaa_t to tiptop;
grant update on psaa_t to tiptop;
grant delete on psaa_t to tiptop;
grant insert on psaa_t to tiptop;

exit;
