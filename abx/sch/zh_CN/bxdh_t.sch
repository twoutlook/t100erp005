/* 
================================================================================
檔案代號:bxdh_t
檔案名稱:保稅機器設備外送單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bxdh_t
(
bxdhent       number(5)      ,/* 企業編號 */
bxdhsite       varchar2(10)      ,/* 營運據點 */
bxdhdocno       varchar2(20)      ,/* 外送單號 */
bxdhdocdt       date      ,/* 單據日期 */
bxdh001       varchar2(20)      ,/* 申請人員 */
bxdh002       varchar2(10)      ,/* 申請部門 */
bxdh010       varchar2(255)      ,/* 備註 */
bxdhownid       varchar2(20)      ,/* 資料所有者 */
bxdhowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdhcrtid       varchar2(20)      ,/* 資料建立者 */
bxdhcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdhcrtdt       timestamp(0)      ,/* 資料創建日 */
bxdhmodid       varchar2(20)      ,/* 資料修改者 */
bxdhmoddt       timestamp(0)      ,/* 最近修改日 */
bxdhcnfid       varchar2(20)      ,/* 資料確認者 */
bxdhcnfdt       timestamp(0)      ,/* 資料確認日 */
bxdhpstid       varchar2(20)      ,/* 資料過帳者 */
bxdhpstdt       timestamp(0)      ,/* 資料過帳日 */
bxdhstus       varchar2(10)      ,/* 狀態碼 */
bxdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdh_t add constraint bxdh_pk primary key (bxdhent,bxdhdocno) enable validate;

create unique index bxdh_pk on bxdh_t (bxdhent,bxdhdocno);

grant select on bxdh_t to tiptop;
grant update on bxdh_t to tiptop;
grant delete on bxdh_t to tiptop;
grant insert on bxdh_t to tiptop;

exit;
