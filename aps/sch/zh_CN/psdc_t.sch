/* 
================================================================================
檔案代號:psdc_t
檔案名稱:供給法則供給檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psdc_t
(
psdcent       number(5)      ,/* 企業編號 */
psdcsite       varchar2(10)      ,/* 營運據點 */
psdc001       varchar2(10)      ,/* 供給法則代號 */
psdcseq       number(10,0)      ,/* 項次 */
psdc002       varchar2(10)      ,/* 供給來源 */
psdc003       varchar2(10)      ,/* 來源檔案 */
psdc004       varchar2(10)      ,/* 欄位代號 */
psdc005       number(5,0)      ,/* 起始碼 */
psdc006       number(5,0)      ,/* 截止碼 */
psdc007       varchar2(100)      ,/* 欄位值 */
psdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psdc_t add constraint psdc_pk primary key (psdcent,psdcsite,psdc001,psdcseq) enable validate;

create unique index psdc_pk on psdc_t (psdcent,psdcsite,psdc001,psdcseq);

grant select on psdc_t to tiptop;
grant update on psdc_t to tiptop;
grant delete on psdc_t to tiptop;
grant insert on psdc_t to tiptop;

exit;
