/* 
================================================================================
檔案代號:psda_t
檔案名稱:供給法則檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table psda_t
(
psdaent       number(5)      ,/* 企業編號 */
psdasite       varchar2(10)      ,/* 營運據點 */
psda001       varchar2(10)      ,/* 供給法則代號 */
psdaownid       varchar2(20)      ,/* 資料所有者 */
psdaowndp       varchar2(10)      ,/* 資料所屬部門 */
psdacrtid       varchar2(20)      ,/* 資料建立者 */
psdacrtdp       varchar2(10)      ,/* 資料建立部門 */
psdacrtdt       timestamp(0)      ,/* 資料創建日 */
psdamodid       varchar2(20)      ,/* 資料修改者 */
psdamoddt       timestamp(0)      ,/* 最近修改日 */
psdastus       varchar2(10)      ,/* 狀態碼 */
psdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psda_t add constraint psda_pk primary key (psdaent,psdasite,psda001) enable validate;

create unique index psda_pk on psda_t (psdaent,psdasite,psda001);

grant select on psda_t to tiptop;
grant update on psda_t to tiptop;
grant delete on psda_t to tiptop;
grant insert on psda_t to tiptop;

exit;
