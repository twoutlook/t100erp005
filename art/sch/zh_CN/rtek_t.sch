/* 
================================================================================
檔案代號:rtek_t
檔案名稱:商戶商品引進單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtek_t
(
rtekent       number(5)      ,/* 企業編號 */
rteksite       varchar2(10)      ,/* 營運組織 */
rtekunit       varchar2(10)      ,/* 應用組織 */
rtekdocno       varchar2(20)      ,/* 單據編號 */
rtekdocdt       date      ,/* 單據日期 */
rtek001       varchar2(10)      ,/* 作業類型 */
rtek002       varchar2(10)      ,/* 商戶編號 */
rtek003       varchar2(20)      ,/* 鋪位編號 */
rtek004       varchar2(1)      ,/* 自動建立商品 */
rtek005       varchar2(20)      ,/* 業務人員 */
rtek006       varchar2(10)      ,/* 業務部門 */
rtek007       varchar2(80)      ,/* 備註 */
rtekstus       varchar2(10)      ,/* 狀態碼 */
rtekownid       varchar2(20)      ,/* 資料所有者 */
rtekowndp       varchar2(10)      ,/* 資料所屬部門 */
rtekcrtid       varchar2(20)      ,/* 資料建立者 */
rtekcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtekcrtdt       timestamp(0)      ,/* 資料創建日 */
rtekmodid       varchar2(20)      ,/* 資料修改者 */
rtekmoddt       timestamp(0)      ,/* 最近修改日 */
rtekcnfid       varchar2(20)      ,/* 資料確認者 */
rtekcnfdt       timestamp(0)      ,/* 資料確認日 */
rtekpstid       varchar2(20)      ,/* 資料過帳者 */
rtekpstdt       timestamp(0)      ,/* 資料過帳日 */
rtekud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtekud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtekud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtekud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtekud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtekud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtekud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtekud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtekud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtekud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtekud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtekud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtekud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtekud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtekud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtekud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtekud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtekud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtekud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtekud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtekud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtekud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtekud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtekud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtekud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtekud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtekud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtekud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtekud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtekud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtek008       varchar2(20)      /* 租賃合約/預租協議 */
);
alter table rtek_t add constraint rtek_pk primary key (rtekent,rtekdocno) enable validate;

create unique index rtek_pk on rtek_t (rtekent,rtekdocno);

grant select on rtek_t to tiptop;
grant update on rtek_t to tiptop;
grant delete on rtek_t to tiptop;
grant insert on rtek_t to tiptop;

exit;
