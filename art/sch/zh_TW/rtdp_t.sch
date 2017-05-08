/* 
================================================================================
檔案代號:rtdp_t
檔案名稱:商品組成用量異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdp_t
(
rtdpent       number(5)      ,/* 企業編號 */
rtdpsite       varchar2(10)      ,/* 營運據點 */
rtdpunit       varchar2(10)      ,/* 應用組織 */
rtdpdocno       varchar2(20)      ,/* 單據編號 */
rtdp001       varchar2(40)      ,/* 主商品編號 */
rtdp002       number(10,0)      ,/* 項次 */
rtdp003       varchar2(40)      ,/* 子商品編號 */
rtdp004       varchar2(40)      ,/* 商品條碼 */
rtdp005       varchar2(10)      ,/* 單位 */
rtdp006       number(20,6)      ,/* 組成用量 */
rtdp007       number(20,6)      ,/* 主件底數 */
rtdp008       number(20,6)      ,/* 變動損耗率 */
rtdp009       number(20,6)      ,/* 固定損耗率 */
rtdp010       number(20,6)      ,/* 成本分攤比例 */
rtdp011       date      ,/* 生效日期時間 */
rtdp012       date      ,/* 失效日期時間 */
rtdpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdp_t add constraint rtdp_pk primary key (rtdpent,rtdpdocno,rtdp002) enable validate;

create  index rtdp_n01 on rtdp_t (rtdp001);
create unique index rtdp_pk on rtdp_t (rtdpent,rtdpdocno,rtdp002);

grant select on rtdp_t to tiptop;
grant update on rtdp_t to tiptop;
grant delete on rtdp_t to tiptop;
grant insert on rtdp_t to tiptop;

exit;
